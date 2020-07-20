//
//  MovieDetailsOverviewCell.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

class MovieDetailsOverviewCell: UITableViewCell, Registerable {
    private static var defaultOverviewLabelConfig: LabelConfig = LabelConfig(font: .plain16, textColor: .mvText, alignment: .justified, numberOfLines: 0)
    
    static var classIdentifier: String {
        return "MovieDetailsOverviewCell"
    }
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .mvBackground
    }
    
    
    func setup(overview: String,
               overviewConfig: LabelConfig = defaultOverviewLabelConfig) {
        overviewLabel.text = overview
        overviewLabel.apply(configuration: overviewConfig)
    }
}
