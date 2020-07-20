//
//  CurrentlyPlayingMapper.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation

protocol CurrentlyPlayingMapper {
    func map(from: [TMDBCurrentMovie]) -> [CurrentMovie]
}

class DefaultCurrentlyPlayingMapper: CurrentlyPlayingMapper {
    func map(from: [TMDBCurrentMovie]) -> [CurrentMovie] {
        return from.map { tmdb in
            return CurrentMovie(posterPath: tmdb.posterPath,
                                overview: tmdb.overview,
                                releaseDate: tmdb.releaseDate,
                                id: tmdb.id,
                                title: tmdb.title,
                                backdropPath: tmdb.backdropPath,
                                voteAverage: tmdb.voteAverage)
        }
    }
}

