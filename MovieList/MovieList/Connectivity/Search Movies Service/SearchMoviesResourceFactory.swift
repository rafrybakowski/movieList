//
//  SearchMoviesResourceFactory.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 19/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation

protocol SearchMoviesResourceFactory {
    func searchMovieResource(query: String) -> Resource<SearchMovieResponse>
}

class DefaultSearchMoviesResourceFactory: SearchMoviesResourceFactory {
    
    private let decoder: JSONDecoderProtocol
    
    private var endpointUrl: String {
        return "/search/movie"
    }
    
    init(decoder: JSONDecoderProtocol = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func searchMovieResource(query: String) -> Resource<SearchMovieResponse> {
        let url = endpointUrl
        let parameters: [String: Any] = ["query": query]
        
        let resource = Resource<SearchMovieResponse>(url: url, parameters: parameters) { [weak self] data in
            guard let sSelf = self else { return .failure(NetworkError.serviceDealocated) }
            do {
                let decodedResponse = try sSelf.decoder.decode(SearchMovieResponse.self, from: data)
                return .success(decodedResponse)
            } catch {
                return .failure(error)
            }
        }
        return resource
    }
}
