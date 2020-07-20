//
//  FlowCoordinatorSpec.swift
//  MovieListTests
//
//  Created by Rafał Rybakowski on 19/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Quick
import Nimble
@testable import MovieList

class FlowCoordinatorSpec: QuickSpec {
    
    override func spec() {
        
        describe("FlowCoordinator") {
            var sut: FlowCoordinator!
            
            var fakeViewControllerFactory: FakeViewControllerFactory!
            var fakeNavigator: FakeNavigator!
            
            beforeEach {
                fakeViewControllerFactory = FakeViewControllerFactory()
                sut = FlowCoordinator(viewControllerFactory: fakeViewControllerFactory)
                fakeNavigator = FakeNavigator(flowCoordinator: sut)
                sut.navigator = fakeNavigator
            }
            
            describe("movieDetailsViewControllerDidRequest") {
                
                context("when selecting an item from the list") {
                    
                    beforeEach {
                        sut.movieDetailsViewControllerDidRequest(detailsFor: CurrentMovie.fixture())
                    }
                    
                    it("should call view controller factory for proper controller") {
                        fakeViewControllerFactory.verifyCall(withIdentifier: "makeMovieDetailsViewController", arguments: [CurrentMovie.fixture()])
                    }
                    
                    it("should push that controller") {
                        fakeNavigator.verifyCall(withIdentifier: "push",
                                                 arguments: ["movieDetailsViewController", true])
                    }
                }
            }
        }
    }
}
