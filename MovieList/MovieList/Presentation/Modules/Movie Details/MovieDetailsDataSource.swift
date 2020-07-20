//
//  MovieDetailsDataSource.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

class MovieDetailsDataSource: NSObject, UITableViewDataSource {
    
    private let movie: CurrentMovie
    private let ratingNumberFormatter: NumberFormatter
    private(set) var cells: [String] = []
    
    init(movie: CurrentMovie,
         ratingNumberFormatter: NumberFormatter) {
        self.movie = movie
        self.ratingNumberFormatter = ratingNumberFormatter
        super.init()
        
        cells = generateCells()
    }
    
    private func generateCells() -> [String] {
        var cells: [String] = []
        
        if movie.posterUrl != nil {
            cells.append(MovieDetailsPosterCell.classIdentifier)
        }
        
        cells.append(MovieDetailsInfoCell.classIdentifier)
        cells.append(MovieDetailsOverviewCell.classIdentifier)
        
        return cells
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = cells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        cell?.selectionStyle = .none
        
        if let posterCell = cell as? MovieDetailsPosterCell {
            posterCell.setup(posterUrl: movie.posterUrl)
            return posterCell
        }
        
        if let infoCell = cell as? MovieDetailsInfoCell {
            let rating = ratingNumberFormatter.string(from: NSNumber(value: movie.voteAverage)) ?? ""
            infoCell.setup(title: movie.title,
                           releaseDate: movie.releaseDate,
                           rating: rating)
            return infoCell
        }
        
        if let overviewCell = cell as? MovieDetailsOverviewCell {
            overviewCell.setup(overview: movie.overview)
            return overviewCell
        }
        
        return UITableViewCell()
    }
}
