//
//  UIImage+Convenience.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 19/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

extension UIImage {
    static var starEmptyTemplate: UIImage? {
        return UIImage(named: "starEmpty")?.withRenderingMode(.alwaysTemplate)
    }
    static var starFilledTemplate: UIImage? {
        return UIImage(named: "starFilled")?.withRenderingMode(.alwaysTemplate)
    }
}
