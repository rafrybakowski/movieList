//
//  CurrentlyPlayingResourceFactory.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation

protocol CurrentlyPlayingResourceFactory {
    func currentlyPlayingResource(page: Int) -> Resource<CurrentlyPlayingResponse>
}

class DefaultCurrentlyPlayingResourceFactory: CurrentlyPlayingResourceFactory {
    
    private let decoder: JSONDecoderProtocol
    
    private var endpointUrl: String {
        return "/movie/now_playing"
    }
    
    init(decoder: JSONDecoderProtocol = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func currentlyPlayingResource(page: Int) -> Resource<CurrentlyPlayingResponse> {
        let url = endpointUrl
        let parameters: [String: Any] = ["page": page]
        
        let resource = Resource<CurrentlyPlayingResponse>(url: url, parameters: parameters) { [weak self] data in
            guard let sSelf = self else { return .failure(NetworkError.serviceDealocated) }
            do {
                let decodedResponse = try sSelf.decoder.decode(CurrentlyPlayingResponse.self, from: data)
                return .success(decodedResponse)
            } catch {
                return .failure(error)
            }
        }
        return resource
    }
}
