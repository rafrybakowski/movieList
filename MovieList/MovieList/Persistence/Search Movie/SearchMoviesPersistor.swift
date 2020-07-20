//
//  SearchMoviePersistor.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 19/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchMoviesPersistor {
    func save(movies: [CurrentMovie])
    var searchMoviesObservable: Observable<[CurrentMovie]> { get }
}

class DefaultSearchMoviesPersistor: SearchMoviesPersistor {
    
    private let encoder: JSONEncoderProtocol
    private let decoder: JSONDecoderProtocol
    private let userDefaults: UserDefaultsProtocol
    
    private let searchMoviesKey = "searchMoviesKey"
    
    private var searchMovies: [CurrentMovie] = [] {
        didSet {
            searchMoviesSubject.onNext(searchMovies)
        }
    }
    
    private var searchMoviesSubject: BehaviorSubject<[CurrentMovie]>!
    var searchMoviesObservable: Observable<[CurrentMovie]> {
        return searchMoviesSubject.asObservable()
    }
    
    init(encoder: JSONEncoderProtocol = JSONEncoder(),
         decoder: JSONDecoderProtocol = JSONDecoder(),
         userDefaults: UserDefaultsProtocol = UserDefaults.standard) {
        self.encoder = encoder
        self.decoder = decoder
        self.userDefaults = userDefaults
        
        self.searchMoviesSubject = BehaviorSubject<[CurrentMovie]>(value: searchMovies)
    }
    
    func save(movies: [CurrentMovie]) {
        self.searchMovies = movies
        searchMoviesSubject.onNext(movies)
        
        // It does not really make sense to save search results,
        // as the user always wants to have fresh data. If needed,
        // it could be done here analogically to favourites
    }
}

