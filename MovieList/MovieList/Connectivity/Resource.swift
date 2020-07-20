//
//  Resource.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url: String
    let parameters: [String: Any]?
    let parsingFunction: (Data) -> Result<T, Error>
    
    init(url: String,
         parameters: [String: Any]? = nil,
         parsingFunction: @escaping (Data) -> Result<T, Error>) {
        self.url = url
        self.parameters = parameters
        self.parsingFunction = parsingFunction
    }
}
