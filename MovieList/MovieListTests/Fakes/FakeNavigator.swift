//
//  FakeNavigator.swift
//  MovieListTests
//
//  Created by Rafał Rybakowski on 19/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Mimus
@testable import MovieList

class FakeNavigator: Navigator, Mock {
    var storage: [RecordedCall] = []
    
    required init(flowCoordinator: FlowCoordinator) { }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        recordCall(withIdentifier: "push", arguments: [viewController.restorationIdentifier, animated])
    }
    
    func present(_ viewController: UIViewController, animated: Bool) {
        recordCall(withIdentifier: "present", arguments: [viewController.restorationIdentifier, animated])
    }
    
    func presentOnTop(_ viewController: UIViewController, animated: Bool) {
        recordCall(withIdentifier: "presentOnTop", arguments: [viewController.restorationIdentifier, animated])
    }
}
