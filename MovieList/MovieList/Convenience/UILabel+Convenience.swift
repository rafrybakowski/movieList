//
//  UILabel+Convenience.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

extension UILabel {
    
    func apply(configuration: LabelConfig) {
        font = configuration.font
        textColor = configuration.textColor
        textAlignment = configuration.alignment
        numberOfLines = configuration.numberOfLines
    }
}
