//
//  CodableInit.swift
//  Movie
//
//  Created by Mohamed Farid on 10/07/2024.
//

import Foundation

protocol CodableInit: Codable {
    init(data: Data) throws
}

extension CodableInit {
    init(data: Data) throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self = try decoder.decode(Self.self, from: data)
    }
}

extension Array: CodableInit where Element: CodableInit {}
