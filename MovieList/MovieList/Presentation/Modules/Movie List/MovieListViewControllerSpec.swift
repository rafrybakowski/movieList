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
                sut = MovieListViewController(currentlyPlayingSynchronizer:
                    DefaultCurrentlyPlayingSynchronizer(currentlyPlayingPersistor: DefaultCurrentlyPlayingPersistor()),
                                              searchMoviesSynchronizer: DefaultSearchMoviesSynchronizer(searchMoviesPersistor: DefaultSearchMoviesPersistor()),
                                              favouriteMoviePersistor: DefaultFavouriteMoviePersistor())
                sut.loadView()
                sut.viewDidLoad()
            }
            
            describe("when initializing") {
                var view: UIView!
                
                beforeEach {
                    view = sut.view
                    SnapshotHelper.prepareViewForSnapshotTest(view)
                }
                
                it("should have proper snapshot") {
                    expect(view).to(haveValidSnapshot())
                }
            }
        }
    }
}
