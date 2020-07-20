//
//  Navigator.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

protocol Navigator: AnyObject {
    init(flowCoordinator: FlowCoordinator)
    func push(_ viewController: UIViewController, animated: Bool)
    func present(_ viewController: UIViewController, animated: Bool)
    func presentOnTop(_ viewController: UIViewController, animated: Bool)
}

class DefaultNavigator: Navigator {
    private var mainNavigationController: UINavigationController
    
    required init(flowCoordinator: FlowCoordinator) {
        self.mainNavigationController = flowCoordinator.mainNavigationController
        flowCoordinator.navigator = self
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        mainNavigationController.pushViewController(viewController, animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool) {
        mainNavigationController.present(viewController, animated: animated)
    }
    
    func presentOnTop(_ viewController: UIViewController, animated: Bool) {
        mainNavigationController.topViewController?.present(viewController, animated: animated)
    }
}

