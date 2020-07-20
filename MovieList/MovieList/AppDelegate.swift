//
//  AppDelegate.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var navigator: Navigator!
    private var flowCoordinator: FlowCoordinator!
    private var windowController: WindowController!
    private var appearanceChanger: AppearanceChanger!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigationStack()
        setupAppearance()
        return true
    }
    
    private func setupNavigationStack() {
        flowCoordinator = FlowCoordinator()
        navigator = DefaultNavigator(flowCoordinator: flowCoordinator)
        windowController = WindowController(rootViewController: flowCoordinator.mainNavigationController)
    }
    
    private func setupAppearance() {
        appearanceChanger = AppearanceChanger()
        appearanceChanger.setupAppAppearance()
    }
}

