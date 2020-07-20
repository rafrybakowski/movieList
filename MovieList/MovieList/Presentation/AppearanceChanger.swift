//
//  AppearanceChanger.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

class AppearanceChanger {
    
    func setupAppAppearance() {
        setupNavigationBarAppearance()
    }
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = .mvMain
        appearance.tintColor = .mvWhite
        appearance.barStyle = .black
        appearance.isTranslucent = false
        
        appearance.titleTextAttributes = [.foregroundColor : UIColor.mvWhite,
                                          .font : UIFont.head20]
    }
}
