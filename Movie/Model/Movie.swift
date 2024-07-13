//
//  Movie.swift
//  Movie
//
//  Created by Mohamed Farid on 13/07/2024.
//

import Foundation

struct Movie: CodableInit, Hashable {
    let adult: Bool
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    var posterPathURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: Constants.NetworkingConfigs.imagesPath + posterPath)
    }
    
    var productionYear: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: releaseDate) {
            formatter.dateFormat = "yyyy"
            return formatter.string(from: date)
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case adult, id, title, video
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Factory

extension Movie {
    static func fake(adult: Bool = true,
                     genreIDS: [Int] = [1],
                     id: Int = 1,
                     originalLanguage: String = "en",
                     originalTitle: String = "",
                     overview: String = "",
                     popularity: Double = 1.2,
                     posterPath: String = "",
                     releaseDate: String = "2024",
                     title: String = "Moana",
                     video: Bool = true,
                     voteAverage: Double = 1.2,
                     voteCount: Int = 10000) -> Movie {
        Movie(adult: adult,
              genreIDS: genreIDS,
              id: id,
              originalLanguage: originalLanguage,
              originalTitle: originalTitle,
              overview: overview,
              popularity: popularity,
              posterPath: posterPath,
              releaseDate: releaseDate,
              title: title,
              video: video,
              voteAverage: voteAverage,
              voteCount: voteCount)
    }
}
