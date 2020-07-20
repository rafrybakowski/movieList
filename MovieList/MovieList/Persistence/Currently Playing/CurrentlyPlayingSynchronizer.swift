//
//  CurrentlyPlayingSynchronizer.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation
import RxSwift

protocol CurrentlyPlayingSynchronizer {
    func fetchMoreData()
    var currentlyPlayingObservable: Observable<[CurrentMovie]> { get }
    var synchronizationStatusObservable: Observable<Bool> { get }
}

class DefaultCurrentlyPlayingSynchronizer: CurrentlyPlayingSynchronizer {
    
    private let currentlyPlayingPersistor: CurrentlyPlayingPersistor
    private let currentlyPlayingService: CurrentlyPlayingService
    private let currentlyPlayingMapper: CurrentlyPlayingMapper
    
    private var synchronizationStatusSubject: BehaviorSubject<Bool>!
    var synchronizationStatusObservable: Observable<Bool>  {
        return synchronizationStatusSubject.asObservable()
    }
    
    var currentlyPlayingObservable: Observable<[CurrentMovie]> {
        return currentlyPlayingPersistor.currentlyPlayingObservable
    }
    
    private var currentPage: Int = 1
    private var maxPages: Int = 1000
    
    init(currentlyPlayingPersistor: CurrentlyPlayingPersistor,
         currentlyPlayingService: CurrentlyPlayingService = DefaultCurrentlyPlayingService(),
         currentlyPlayingMapper: CurrentlyPlayingMapper = DefaultCurrentlyPlayingMapper()) {
        self.currentlyPlayingPersistor = currentlyPlayingPersistor
        self.currentlyPlayingService = currentlyPlayingService
        self.currentlyPlayingMapper = currentlyPlayingMapper
        
        self.synchronizationStatusSubject = BehaviorSubject<Bool>(value: false)
    }
    
    func fetchMoreData() {
        print(currentPage)
        // Due to time limitations, a very simple EOC check
        if currentPage >= maxPages {
            return
        }
        
        synchronizationStatusSubject.onNext(true)
        currentlyPlayingService.fetchCurrentlyPlaying(page: currentPage) { [weak self] result in
            guard let sSelf = self else { return }
            sSelf.synchronizationStatusSubject.onNext(false)
            switch result {
            case .success(let response):
                if !response.results.isEmpty {
                    sSelf.currentPage += 1
                }
                sSelf.maxPages = response.totalPages
                sSelf.save(tmdbMovies: response.results)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    private func save(tmdbMovies: [TMDBCurrentMovie]) {
        let mappedMovies = currentlyPlayingMapper.map(from: tmdbMovies)
        currentlyPlayingPersistor.save(movies: mappedMovies)
    }
}
