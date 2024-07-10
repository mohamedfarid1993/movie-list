//
//  Constants.swift
//  Movie
//
//  Created by Mohamed Farid on 10/07/2024.
//

import Foundation

enum Constants {
    
    // MARK: Networking Configuration
    
    enum NetworkingConfigs {
        static let acceptHeaderKey = "Accept"
        static let acceptHeaderValue = "application/json"
        static let pageParameterKey = "page"
        static let apiKey = "api_key"
        static let baseURL = "https://api.themoviedb.org/3"
    }
    
    // MARK: Networking Keys
    
    enum NetworkingKeys {
        static let apiKeyValue = "170e5887e5097670b9f23022776716ed"
    }
}
