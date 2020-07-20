//
//  MovieDetailsInfoCell.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

class MovieDetailsInfoCell: UITableViewCell, Registerable {
    private static var defaultTitleLabelConfig: LabelConfig = LabelConfig(font: .head20, textColor: .mvText, alignment: .left, numberOfLines: 0)
    private static var defaultDateLabelConfig: LabelConfig = LabelConfig(font: .plain16, textColor: .mvLightText, alignment: .left, numberOfLines: 1)
    private static var defaultRatingLabelConfig: LabelConfig = LabelConfig(font: .head28, textColor: .mvMain, alignment: .center, numberOfLines: 1)
    private static var defaulReleasedLabelConfig: LabelConfig = LabelConfig(font: .plain12, textColor: .mvLightText, alignment: .left, numberOfLines: 1)
    private static var defaultReleased: String = "Released"
    
    static var classIdentifier: String {
        return "MovieDetailsInfoCell"
    }
        
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .mvBackground
    }
    
    func setup(title: String,
               titleConfig: LabelConfig = defaultTitleLabelConfig,
               releaseDate: String,
               releaseDateConfig: LabelConfig = defaultDateLabelConfig,
               rating: String,
               ratingConfig: LabelConfig = defaultRatingLabelConfig,
               released: String = defaultReleased,
               releasedConfig: LabelConfig = defaulReleasedLabelConfig) {
        titleLabel.text = title
        titleLabel.apply(configuration: titleConfig)
        releaseDateLabel.text = releaseDate
        releaseDateLabel.apply(configuration: releaseDateConfig)
        ratingLabel.text = rating
        ratingLabel.apply(configuration: ratingConfig)
        releasedLabel.text = released
        releasedLabel.apply(configuration: releasedConfig)
    }
}
