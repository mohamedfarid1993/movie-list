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
    case getGenres
    
    // MARK: Properties
    
    static let moviesPath = "movie/popular"
    static let genresPath = "genre/movie/list"
}

extension MoviesRouter {
        
    var path: String {
        switch self {
        case .getPopularMovies:
            return MoviesRouter.moviesPath
        case .getGenres:
            return MoviesRouter.genresPath
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getPopularMovies(let page):
            return [Constants.NetworkingConfigs.pageParameterKey: page]
        case .getGenres:
            return [:]
        }
    }
    
    var method: HTTPMethod {
        .get
    }
}
