//
//  API.swift
//  Movie
//
//  Created by Mohamed Farid on 10/07/2024.
//

import Combine

protocol API {
    static func getMovies(in page: Int) async throws -> MoviesResponse
    static func getGenres() async throws -> GenresResponse
    static func searchMovies(with text: String, in page: Int) async throws -> MoviesResponse
}
