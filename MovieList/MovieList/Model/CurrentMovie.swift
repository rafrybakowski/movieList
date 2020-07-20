//
//  CurrentMovie.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation

struct CurrentMovie: Codable {
    let posterPath: String?
    let overview: String
    let releaseDate: String
    let id: Int
    let title: String
    let backdropPath: String?
    let voteAverage: Double
    
    var posterUrl: URL? {
        guard let path = posterPath else { return nil }
        let urlString = "https://image.tmdb.org/t/p/w500\(path)"
        return URL(string: urlString)
    }
    
    var backdropUrl: URL? {
        guard let path = backdropPath else { return nil }
        let urlString = "https://image.tmdb.org/t/p/w500\(path)"
        return URL(string: urlString)
    }
}
