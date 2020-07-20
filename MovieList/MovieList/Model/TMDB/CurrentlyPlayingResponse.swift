//
//  CurrentlyPlayingResponse.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation

struct CurrentlyPlayingResponse: Codable {
    
    let page: Int
    let results: [TMDBCurrentMovie]
    let totalPages: Int
    let totalResults: Int
    
    private enum CodingKeys : String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
