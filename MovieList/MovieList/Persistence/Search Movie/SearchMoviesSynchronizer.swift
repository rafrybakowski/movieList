//
//  SearchMovieSynchronizer.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 19/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchMoviesSynchronizer {
    func search(query: String)
    var searchMoviesObservable: Observable<[CurrentMovie]> { get }
    var synchronizationStatusObservable: Observable<Bool> { get }
}

class DefaultSearchMoviesSynchronizer: SearchMoviesSynchronizer {
    
    private let searchMoviesPersistor: SearchMoviesPersistor
    private let searchMoviesService: SearchMoviesService
    private let searchMoviesMapper: SearchMoviesMapper
    
    private var synchronizationStatusSubject: BehaviorSubject<Bool>!
    var synchronizationStatusObservable: Observable<Bool>  {
        return synchronizationStatusSubject.asObservable()
    }
    
    var searchMoviesObservable: Observable<[CurrentMovie]> {
        return searchMoviesPersistor.searchMoviesObservable
    }
    
    init(searchMoviesPersistor: SearchMoviesPersistor,
         searchMoviesService: SearchMoviesService = DefaultSearchMoviesService(),
         searchMoviesMapper: SearchMoviesMapper = DefaultSearchMoviesMapper()) {
        self.searchMoviesPersistor = searchMoviesPersistor
        self.searchMoviesService = searchMoviesService
        self.searchMoviesMapper = searchMoviesMapper
        
        self.synchronizationStatusSubject = BehaviorSubject<Bool>(value: false)
    }
    
    func search(query: String) {
        synchronizationStatusSubject.onNext(true)
        
        searchMoviesService.fetchSearchResults(query: query) { [weak self] result in
            guard let sSelf = self else { return }
            sSelf.synchronizationStatusSubject.onNext(false)
            switch result {
            case .success(let response):
                sSelf.save(tmdbMovies: response.results)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    private func save(tmdbMovies: [TMDBCurrentMovie]) {
        let mappedMovies = searchMoviesMapper.map(from: tmdbMovies)
        searchMoviesPersistor.save(movies: mappedMovies)
    }
}
