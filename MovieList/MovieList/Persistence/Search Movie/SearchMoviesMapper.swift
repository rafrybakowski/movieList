//
//  SearchMovieMapper.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 19/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation

protocol SearchMoviesMapper {
    func map(from: [TMDBCurrentMovie]) -> [CurrentMovie]
}

class DefaultSearchMoviesMapper: SearchMoviesMapper {
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

