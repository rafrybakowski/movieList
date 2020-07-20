//
//  WindowController.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

class WindowController {
    private let window: UIWindow
    
    init(window: UIWindow = UIWindow(frame: UIScreen.main.bounds),
         rootViewController: UIViewController) {
        self.window = window
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }
}
