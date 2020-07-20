//
//  UIColor+Pallete.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

extension UIColor {
        
    static var mvMain: UIColor {
        return UIColor.makeFrom(hex: "0066CC")
    }
    
    static var mvWhite: UIColor {
        return UIColor.makeFrom(hex: "FFFFFF")
    }
    
    static var mvBlack: UIColor {
        return UIColor.makeFrom(hex: "000000")
    }
    
    static var mvText: UIColor {
        return UIColor.makeFrom(hex: "2D2D2D")
    }
    
    static var mvLightText: UIColor {
        return UIColor.makeFrom(hex: "5D5D5D")
    }
    
    static var mvGray: UIColor {
        return UIColor.makeFrom(hex: "B1B3B3")
    }
    
    static var mvLightGray: UIColor {
        return UIColor.makeFrom(hex: "E8E8E8")
    }
    
    static var mvBackground: UIColor {
        return UIColor.makeFrom(hex: "F2F7FC")
    }
    
    static func makeFrom(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

