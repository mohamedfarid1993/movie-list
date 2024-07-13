//
//  Genre.swift
//  Movie
//
//  Created by Mohamed Farid on 13/07/2024.
//

import Foundation

struct Genre: CodableInit{
    let id: Int
    let name: String
}

// MARK: - Factory

extension Genre {
    static func fake(id: Int = 1, name: String = "Action") -> Genre {
        Genre(id: id, name: name)
    }
}
