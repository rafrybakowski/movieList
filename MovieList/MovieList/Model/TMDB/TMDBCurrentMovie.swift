//
//  TMDBCurrentMovie.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation

struct TMDBCurrentMovie: Codable {
    
    let posterPath: String?
    let overview: String
    let releaseDate: String
    let id: Int
    let title: String
    let backdropPath: String?
    let voteAverage: Double
    
    private enum CodingKeys : String, CodingKey {
        case posterPath = "poster_path"
        case overview = "overview"
        case releaseDate = "release_date"
        case id = "id"
        case title = "title"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
    }
}

