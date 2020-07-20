//
//  CurrentlyPlayingService.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation

protocol CurrentlyPlayingService {
    func fetchCurrentlyPlaying(page: Int, completion: @escaping (Result<CurrentlyPlayingResponse, Error>) -> Void)
}

class DefaultCurrentlyPlayingService: CurrentlyPlayingService {
    private let apiClient: ApiClient
    private let currentlyPlayingResourceFactory: CurrentlyPlayingResourceFactory
    
    init(apiClient: ApiClient = DefaultApiClient.shared,
         currentlyPlayingResourceFactory: CurrentlyPlayingResourceFactory = DefaultCurrentlyPlayingResourceFactory()) {
        self.apiClient = apiClient
        self.currentlyPlayingResourceFactory = currentlyPlayingResourceFactory
    }
    
    func fetchCurrentlyPlaying(page: Int, completion: @escaping (Result<CurrentlyPlayingResponse, Error>) -> Void) {
        let resource = currentlyPlayingResourceFactory.currentlyPlayingResource(page: page)
        apiClient.executeRequest(for: resource, completion: completion)
    }
}
