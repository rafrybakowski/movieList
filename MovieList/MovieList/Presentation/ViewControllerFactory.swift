//
//  ViewControllerFactory.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

protocol ViewControllerFactory {
    func makeMovieListViewController(delegate: MovieListViewControllerDelegate) -> UIViewController
    func makeMovieDetailsViewController(movie: CurrentMovie) -> UIViewController
    func makeAlertViewController(title: String) -> UIViewController
}

class DefaultViewControllerFactory: ViewControllerFactory {
    
    func makeMovieListViewController(delegate: MovieListViewControllerDelegate) -> UIViewController {
        let movieListViewController = MovieListViewController(currentlyPlayingSynchronizer: CONTAINER.currentlyPlayingSynchronizer,
                                                              searchMoviesSynchronizer: CONTAINER.searchMoviesSynchronizer,
                                                              favouriteMoviePersistor: CONTAINER.favouriteMoviePersistor)
        movieListViewController.delegate = delegate
        return movieListViewController
    }
    
    func makeMovieDetailsViewController(movie: CurrentMovie) -> UIViewController {
        let movieDetailsViewController = MovieDetailsViewController(movie: movie,
                                                                    favouriteMoviePersistor: CONTAINER.favouriteMoviePersistor)
        return movieDetailsViewController
    }
    
    func makeAlertViewController(title: String) -> UIViewController {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(alertAction)
        return alert
    }
}
