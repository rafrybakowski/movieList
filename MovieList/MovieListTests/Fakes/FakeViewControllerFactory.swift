//
//  FakeViewControllerFactory.swift
//  MovieListTests
//
//  Created by Rafał Rybakowski on 19/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

@testable import MovieList
import Mimus

class FakeViewControllerFactory: ViewControllerFactory, Mock {
    var storage: [RecordedCall] = []
    
    func makeMovieListViewController(delegate: MovieListViewControllerDelegate) -> UIViewController {
        recordCall(withIdentifier: "makeMovieListViewController")
        let result = UIViewController()
        result.restorationIdentifier = "movieListViewController"
        return result
    }
    
    func makeMovieDetailsViewController(movie: CurrentMovie) -> UIViewController {
        recordCall(withIdentifier: "makeMovieDetailsViewController", arguments: [movie])
        let result = UIViewController()
        result.restorationIdentifier = "movieDetailsViewController"
        return result
    }
    
    func makeAlertViewController(title: String) -> UIViewController {
        recordCall(withIdentifier: "makeAlertViewController")
        let result = UIViewController()
        result.restorationIdentifier = "alertViewController"
        return result
    }
}

