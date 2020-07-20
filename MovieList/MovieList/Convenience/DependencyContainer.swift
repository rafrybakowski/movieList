//
//  DependencyContainer.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import RxSwift

var CONTAINER: DependencyContainer { return DependencyContainer.instance }

class DependencyContainer {
    static let instance = DependencyContainer()
        
    private(set) lazy var currentlyPlayingSynchronizer: CurrentlyPlayingSynchronizer = DefaultCurrentlyPlayingSynchronizer(currentlyPlayingPersistor: DefaultCurrentlyPlayingPersistor())
    private(set) lazy var searchMoviesSynchronizer: SearchMoviesSynchronizer = DefaultSearchMoviesSynchronizer(searchMoviesPersistor: DefaultSearchMoviesPersistor())
    private(set) lazy var favouriteMoviePersistor: FavouriteMoviePersistor = DefaultFavouriteMoviePersistor()

    private init() {}
}
