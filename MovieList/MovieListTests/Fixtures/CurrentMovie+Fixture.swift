//
//  CurrentMovie+Fixture.swift
//  MovieListTests
//
//  Created by Rafał Rybakowski on 19/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Mimus
@testable import MovieList

extension CurrentMovie {
    
    static func fixture(posterPath: String? = "fixture",
                        overview: String = "fixture",
                        releaseDate: String = "fixture",
                        id: Int = 42,
                        title: String = "fixture",
                        backdropPath: String? = "fixture",
                        voteAverage: Double = 4.2) -> CurrentMovie {
        return CurrentMovie(posterPath: posterPath,
                            overview: overview,
                            releaseDate: releaseDate,
                            id: id,
                            title: title,
                            backdropPath: backdropPath,
                            voteAverage: voteAverage)
    }
}

extension CurrentMovie: MockEquatable {
    
    public func equalTo(other: Any?) -> Bool {
        guard let other = other as? CurrentMovie else { return false }
        return id == other.id
    }
}

