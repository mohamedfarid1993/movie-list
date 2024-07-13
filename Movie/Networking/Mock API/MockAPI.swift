//
//  MockAPI.swift
//  Movie
//
//  Created by Mohamed Farid on 10/07/2024.
//

import Combine

enum MockAPI { }

// MARK: - API

extension MockAPI: API {
    static func getMovies(in page: Int) async throws -> MoviesResponse {
        MoviesResponse.fake()
    }
    
    static func getGenres() async throws -> GenresResponse {
        GenresResponse.fake()
    }
    
    static func searchMovies(with text: String, in page: Int) async throws -> MoviesResponse {
        MoviesResponse.fake()
    }
}
