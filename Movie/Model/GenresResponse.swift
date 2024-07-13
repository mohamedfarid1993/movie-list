//
//  GenresResponse.swift
//  Movie
//
//  Created by Mohamed Farid on 13/07/2024.
//

import Foundation

struct GenresResponse: CodableInit {
    let genres: [Genre]
}

// MARK: - Factory

extension GenresResponse {
    static func fake(genres: [Genre] = [Genre.fake()]) -> GenresResponse {
        GenresResponse(genres: genres)
    }
}
