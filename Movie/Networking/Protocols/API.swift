//
//  API.swift
//  Movie
//
//  Created by Mohamed Farid on 10/07/2024.
//

import Combine

protocol API {
    static func getMovies(in page: Int) async throws -> MoviesResponse
}
