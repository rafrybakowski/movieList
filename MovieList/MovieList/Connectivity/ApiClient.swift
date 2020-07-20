//
//  ApiClient.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidResponse(message: String)
    case serviceDealocated
    case couldNotReceiveProperData
}

protocol ApiClient {
    func executeRequest<T>(for resource: Resource<T>, completion: @escaping (Result<T, Error>) -> Void)
}

class DefaultApiClient: ApiClient {
    static let shared = DefaultApiClient()
    private init() {}
    
    private var baseUrl: String {
        return "https://api.themoviedb.org/3"
    }
    
    private var apiKey: String {
        return "ce6db8dd5557a642cd78e2f6cc51926a"
    }
    
    private var authParameters: [String: Any] {
        return ["api_key": apiKey]
    }
    
    func executeRequest<T>(for resource: Resource<T>, completion: @escaping (Result<T, Error>) -> Void) {
        
        let url = baseUrl + resource.url
        let generalParameters: [String: Any] = authParameters
        let allParameters = generalParameters.merging(resource.parameters ?? [:]) { (current, _) in current }
        
        AF.request(url, parameters: allParameters)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let responseData):
                    completion(resource.parsingFunction(responseData))
                    return
                case .failure(_):
                    completion(.failure(NetworkError.couldNotReceiveProperData))
                    return
                }
        }
    }
}
