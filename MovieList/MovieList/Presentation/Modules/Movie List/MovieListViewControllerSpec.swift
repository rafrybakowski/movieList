//
//  MovieListViewControllerSpec.swift
//  MovieListTests
//
//  Created by Rafał Rybakowski on 10/08/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import MovieList

class MovieListViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("MovieListViewController") {
            var sut: MovieListViewController!
            
            beforeEach {
                let currentlyPlayingPersistor = DefaultCurrentlyPlayingPersistor()
                let currentlyPlayingSynchronizer = DefaultCurrentlyPlayingSynchronizer(currentlyPlayingPersistor: currentlyPlayingPersistor)
                let searchMoviesPersistor = DefaultSearchMoviesPersistor()
                let searchMoviesSynchronizer = DefaultSearchMoviesSynchronizer(searchMoviesPersistor: searchMoviesPersistor)
                let moviePersistor = DefaultFavouriteMoviePersistor()
                
                currentlyPlayingPersistor.save(movies: [CurrentMovie.fixture()])
                
                sut = MovieListViewController(currentlyPlayingSynchronizer: currentlyPlayingSynchronizer,
                                              searchMoviesSynchronizer: searchMoviesSynchronizer,
                                              favouriteMoviePersistor: moviePersistor)
                
                // Setup the sut
                // ...
                
                // Call lifecycle methods to setup the view hierarchy
                sut.loadView()
                sut.viewDidLoad()
            }
            
            context("when initializing") {
                var view: UIView!
                
                beforeEach {
                    view = sut.view
                    SnapshotHelper.prepareViewForSnapshotTest(view)
                }
                
                it("should have proper snapshot") {
//                    expect(view).to(recordSnapshot()) // recording snapshots
                    expect(view).to(haveValidSnapshot()) // validating snapshots
                }
            }
        }
    }
}
