//
//  MovieDetailsPosterCell.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

class MovieDetailsPosterCell: UITableViewCell, Registerable {
    
    static var classIdentifier: String {
        return "MovieDetailsPosterCell"
    }
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .mvBackground
        imageView?.contentMode = .scaleAspectFill
    }
    
    func setup(posterUrl: URL?) {
        posterImageView.kf.setImage(with: posterUrl)
    }
}
