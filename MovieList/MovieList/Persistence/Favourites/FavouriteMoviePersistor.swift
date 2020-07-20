//
//  FavouriteMoviePersistor.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 19/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation
import RxSwift

protocol FavouriteMoviePersistor {
    func add(favouriteMovie: CurrentMovie)
    func remove(favouriteMovie: CurrentMovie)
    var favouriteMovies: [Int: CurrentMovie] { get }
    var currentFavouritesObservable: Observable<[Int: CurrentMovie]> { get }
}

class DefaultFavouriteMoviePersistor: FavouriteMoviePersistor {
    
    private let encoder: JSONEncoderProtocol
    private let decoder: JSONDecoderProtocol
    private let userDefaults: UserDefaultsProtocol
    
    private let favouriteMoviesKey = "favouriteMoviesKey"
    
    private(set) var favouriteMovies: [Int: CurrentMovie] = [:] {
        didSet {
            currentFavouritesSubject.onNext(favouriteMovies)
        }
    }
    
    private var currentFavouritesSubject: BehaviorSubject<[Int: CurrentMovie]>!
    var currentFavouritesObservable: Observable<[Int: CurrentMovie]> {
        return currentFavouritesSubject.asObservable()
    }
    
    init(encoder: JSONEncoderProtocol = JSONEncoder(),
         decoder: JSONDecoderProtocol = JSONDecoder(),
         userDefaults: UserDefaultsProtocol = UserDefaults.standard) {
        self.encoder = encoder
        self.decoder = decoder
        self.userDefaults = userDefaults
        
        self.favouriteMovies = load()
        self.currentFavouritesSubject = BehaviorSubject<[Int: CurrentMovie]>(value: favouriteMovies)
    }
    
    func add(favouriteMovie: CurrentMovie) {
        favouriteMovies[favouriteMovie.id] = favouriteMovie
        save(movies: favouriteMovies)
    }
    
    func remove(favouriteMovie: CurrentMovie) {
        _ = favouriteMovies.removeValue(forKey: favouriteMovie.id)
        save(movies: favouriteMovies)
    }
    
    func save(movies: [Int: CurrentMovie]) {
        self.favouriteMovies = movies
        currentFavouritesSubject.onNext(movies)

        guard let encodedMovies = try? encoder.encode(movies) else {
            print("Unable to encode favourite movies")
            return
        }

        userDefaults.set(encodedMovies, forKey: favouriteMoviesKey)
    }
    
    private func load() -> [Int: CurrentMovie] {
        guard let loadedMovies = userDefaults.object(forKey: favouriteMoviesKey) as? Data else {
            print("Unable to load favourite movies")
            return [:]
        }

        guard let decodedMovies = try? decoder.decode([Int: CurrentMovie].self, from: loadedMovies) else {
            print("Unable to decode favourite movies")
            return [:]
        }

        return decodedMovies
    }
}

