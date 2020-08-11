//
//  CurrentlyPlayingPersistor.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation
import RxSwift

protocol CurrentlyPlayingPersistor {
    func save(movies: [CurrentMovie])
    var currentlyPlayingObservable: Observable<[CurrentMovie]> { get }
}

class DefaultCurrentlyPlayingPersistor: CurrentlyPlayingPersistor {
    
    private let encoder: JSONEncoderProtocol
    private let decoder: JSONDecoderProtocol
    private let userDefaults: UserDefaultsProtocol
    
    private let currentMoviesKey = "currentMoviesKey"
    
    private var currentMovies: [CurrentMovie] = [] {
        didSet {
            currentlyPlayingSubject.onNext(currentMovies)
        }
    }
    
    private var currentlyPlayingSubject: BehaviorSubject<[CurrentMovie]>!
    var currentlyPlayingObservable: Observable<[CurrentMovie]> {
        return currentlyPlayingSubject.asObservable()
    }
    
    init(encoder: JSONEncoderProtocol = JSONEncoder(),
         decoder: JSONDecoderProtocol = JSONDecoder(),
         userDefaults: UserDefaultsProtocol = UserDefaults.standard) {
        self.encoder = encoder
        self.decoder = decoder
        self.userDefaults = userDefaults
        
        currentMovies = [CurrentMovie(posterPath: "",
                                      overview: "A decent movie",
                                      releaseDate: "02-2020",
                                      id: 1,
                                      title: "Decent Movie",
                                      backdropPath: "",
                                      voteAverage: 8.0)]
//        currentMovies.append(CurrentMovie(posterPath: "",
//                                          overview: "A terrible movie",
//                                          releaseDate: "02-2020",
//                                          id: 1,
//                                          title: "Terrible Movie",
//                                          backdropPath: "",
//                                          voteAverage: 1.0))
        self.currentlyPlayingSubject = BehaviorSubject<[CurrentMovie]>(value: currentMovies)
    }
    
    func save(movies: [CurrentMovie]) {
        self.currentMovies += movies
        currentlyPlayingSubject.onNext(currentMovies)
        
        // It does not really make sense to save currently played movies,
        // as the user always wants to have fresh data. If needed,
        // it could be done here analogically to favourites
    }
}
