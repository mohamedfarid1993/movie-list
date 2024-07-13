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
}
