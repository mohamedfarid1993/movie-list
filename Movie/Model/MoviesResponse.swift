//
//  MoviesResponse.swift
//  Movie
//
//  Created by Mohamed Farid on 13/07/2024.
//

import Foundation

struct MoviesResponse: CodableInit {
    let page: Int
    let movies: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


// MARK: - Factory

extension MoviesResponse {
    static func fake(page: Int = 1,
                     movies: [Movie] = [Movie.fake()],
                     totalPages: Int = 10,
                     totalResults: Int = 10) -> MoviesResponse {
        MoviesResponse(page: page, movies: movies, totalPages: totalPages, totalResults: totalResults)
    }
}
