//
//  SearchMoviesService.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 19/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation

protocol SearchMoviesService {
    func fetchSearchResults(query: String, completion: @escaping (Result<SearchMovieResponse, Error>) -> Void)
}

class DefaultSearchMoviesService: SearchMoviesService {
    private let apiClient: ApiClient
    private let searchMoviesResourceFactory: SearchMoviesResourceFactory
    
    init(apiClient: ApiClient = DefaultApiClient.shared,
         searchMoviesResourceFactory: SearchMoviesResourceFactory = DefaultSearchMoviesResourceFactory()) {
        self.apiClient = apiClient
        self.searchMoviesResourceFactory = searchMoviesResourceFactory
    }
    
    func fetchSearchResults(query: String, completion: @escaping (Result<SearchMovieResponse, Error>) -> Void) {
        let resource = searchMoviesResourceFactory.searchMovieResource(query: query)
        apiClient.executeRequest(for: resource, completion: completion)
    }
}
