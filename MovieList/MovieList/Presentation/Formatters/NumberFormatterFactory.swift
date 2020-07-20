//
//  NumberFormatterFactory.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation

protocol NumberFormatterFactory {
    func makeRatingNumberFormatter() -> NumberFormatter
}

class DefaultNumberFormatterFactory: NumberFormatterFactory {
    func makeRatingNumberFormatter() -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter
    }
}
