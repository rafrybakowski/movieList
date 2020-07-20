//
//  MovieListItemCell.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit
import Kingfisher

protocol MovieListItemCellDelegate: AnyObject {
    func movieListFavouriteSelected(at indexPath: IndexPath)
}

class MovieListItemCell: UITableViewCell, Registerable {
    private static var defaultTitleLabelConfig: LabelConfig = LabelConfig(font: .head20, textColor: .mvText, alignment: .left, numberOfLines: 2)
    private static var defaultDateLabelConfig: LabelConfig = LabelConfig(font: .plain16, textColor: .mvLightText, alignment: .left, numberOfLines: 1)
    private static var defaultRatingLabelConfig: LabelConfig = LabelConfig(font: .head28, textColor: .mvMain, alignment: .center, numberOfLines: 1)
    private static var defaulReleasedLabelConfig: LabelConfig = LabelConfig(font: .plain12, textColor: .mvLightText, alignment: .left, numberOfLines: 1)
    private static var defaultReleased: String = "Released"
    
    static var classIdentifier: String {
        return "MovieListItemCell"
    }
    
    static var defaultHeight: CGFloat = 136

    private var indexPath: IndexPath?
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var releasedLabel: UILabel!
    @IBOutlet private weak var favouriteButton: UIButton!
    
    weak var delegate: MovieListItemCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .mvBackground
        
        containerView.backgroundColor = .mvWhite
        containerView.cornerRadius = 5
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.cornerRadius = 5
        
        favouriteButton.tintColor = .mvMain
    }
    
    func setup(title: String,
               titleConfig: LabelConfig = defaultTitleLabelConfig,
               releaseDate: String,
               releaseDateConfig: LabelConfig = defaultDateLabelConfig,
               rating: String,
               ratingConfig: LabelConfig = defaultRatingLabelConfig,
               released: String = defaultReleased,
               releasedConfig: LabelConfig = defaulReleasedLabelConfig,
               posterUrl: URL?,
               isFavourite: Bool,
               indexPath: IndexPath? = nil) {
        titleLabel.text = title
        titleLabel.apply(configuration: titleConfig)
        releaseDateLabel.text = releaseDate
        releaseDateLabel.apply(configuration: releaseDateConfig)
        ratingLabel.text = rating
        ratingLabel.apply(configuration: ratingConfig)
        releasedLabel.text = released
        releasedLabel.apply(configuration: releasedConfig)

        posterImageView.kf.setImage(with: posterUrl, placeholder: UIImage(named: "placeholder"))
        
        setupFavouritesButton(isFavourite: isFavourite)
        
        self.indexPath = indexPath
    }
    
    private func setupFavouritesButton(isFavourite: Bool) {
        let image = isFavourite ? UIImage.starFilledTemplate : UIImage.starEmptyTemplate
        favouriteButton.setImage(image, for: .normal)
    }
    
    @IBAction func favouriteButtonPressed() {
        guard let indexPath = indexPath else { return }
        delegate?.movieListFavouriteSelected(at: indexPath)
    }
}
