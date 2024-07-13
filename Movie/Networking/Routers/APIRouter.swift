//
//  APIRouter..swift
//  Movie
//
//  Created by Mohamed Farid on 10/07/2024.
//

import Combine

enum APIRouter {}

// MARK: - API

extension APIRouter: API {
    static func getMovies(in page: Int) async throws -> MoviesResponse {
        try await MoviesRouter.getPopularMovies(page: page)
            .send(MoviesResponse.self)
    }
    
    static func getGenres() async throws -> GenresResponse {
        try await MoviesRouter.getGenres
            .send(GenresResponse.self)
    }
}
