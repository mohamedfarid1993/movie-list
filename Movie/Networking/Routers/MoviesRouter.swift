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
    case searchMovies(text: String, page: Int)
    
    // MARK: Properties
    
    static let moviesPath = "movie/popular"
    static let genresPath = "genre/movie/list"
    static let searchMoviesPath = "search/movie"
    static let moviesSearchQueryKey = "query"
}

extension MoviesRouter {
        
    var path: String {
        switch self {
        case .getPopularMovies:
            return MoviesRouter.moviesPath
        case .getGenres:
            return MoviesRouter.genresPath
        case .searchMovies:
            return MoviesRouter.searchMoviesPath
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getPopularMovies(let page):
            return [Constants.NetworkingConfigs.pageParameterKey: page]
        case .getGenres:
            return [:]
        case .searchMovies(let text, let page):
            return [
                Constants.NetworkingConfigs.pageParameterKey: page,
                MoviesRouter.moviesSearchQueryKey: text
            ]
        }
    }
    
    var method: HTTPMethod {
        .get
    }
}
