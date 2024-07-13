//
//  MoviesRouter..swift
//  Movie
//
//  Created by Mohamed Farid on 10/07/2024.
//

import Foundation
import Alamofire

enum MoviesRouter: URLRequestBuilder {
        
    // MARK: - APIs
    
    case getPopularMovies(page: Int)
    
    // MARK: Properties
    
    static let moviesPath = "movie/popular"
}

extension MoviesRouter {
        
    var path: String {
        switch self {
        case .getPopularMovies:
            return MoviesRouter.moviesPath
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getPopularMovies(let page):
            return [Constants.NetworkingConfigs.pageParameterKey: page]
        }
    }
    
    var method: HTTPMethod {
        .get
    }
}
