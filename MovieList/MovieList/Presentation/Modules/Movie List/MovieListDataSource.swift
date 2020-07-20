//
//  MovieListDataSource.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

protocol MovieListDataSourceDelegate: AnyObject {
    func movieListFavouriteSelected(at indexPath: IndexPath)
}

class MovieListDataSource: NSObject, UITableViewDataSource {
    
    private let ratingNumberFormatter: NumberFormatter
    
    weak var delegate: MovieListDataSourceDelegate?
    
    init(ratingNumberFormatter: NumberFormatter) {
        self.ratingNumberFormatter = ratingNumberFormatter
    }
    
    var items: [CurrentMovie] = []
    var favouriteItems: [Int: CurrentMovie] = [:]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListItemCell.classIdentifier) as? MovieListItemCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        let item = items[indexPath.row]
        let rating = ratingNumberFormatter.string(from: NSNumber(value: item.voteAverage)) ?? ""
        let isFavourite = favouriteItems[item.id] != nil
        cell.setup(title: item.title,
                   releaseDate: item.releaseDate,
                   rating: rating,
                   posterUrl: item.posterUrl,
                   isFavourite: isFavourite,
                   indexPath: indexPath)
        cell.delegate = self
        return cell
    }
}

extension MovieListDataSource: MovieListItemCellDelegate {
    func movieListFavouriteSelected(at indexPath: IndexPath) {
        delegate?.movieListFavouriteSelected(at: indexPath)
    }
}
