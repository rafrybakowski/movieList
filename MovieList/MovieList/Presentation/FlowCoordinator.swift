//
//  FlowCoordinator.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

class FlowCoordinator {
    private let viewControllerFactory: ViewControllerFactory
    private(set) var mainNavigationController: UINavigationController!
    weak var navigator: Navigator!
    
    init(viewControllerFactory: ViewControllerFactory = DefaultViewControllerFactory()) {
        self.viewControllerFactory = viewControllerFactory
        
        let rootViewController = viewControllerFactory.makeMovieListViewController(delegate: self)
        self.mainNavigationController = UINavigationController(rootViewController: rootViewController)
    }
    
    private func showAlert(with title: String) {
        let alert = viewControllerFactory.makeAlertViewController(title: title)
        navigator.presentOnTop(alert, animated: true)
    }
}

extension FlowCoordinator: MovieListViewControllerDelegate {
    func movieDetailsViewControllerDidRequest(detailsFor movie: CurrentMovie) {
        let movieDetailsController = viewControllerFactory.makeMovieDetailsViewController(movie: movie)
        navigator.push(movieDetailsController, animated: true)
    }
}
