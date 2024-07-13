//
//  MoviesListViewModel.swift
//  Movie
//
//  Created by Mohamed Farid on 13/07/2024.
//

import Foundation

@MainActor
class MoviesListViewModel: ObservableObject {
    enum State: Equatable {
        case loading, loaded, failed(error: Error, genresFetchingFailed: Bool)
        
        static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading), (.loaded, .loaded), (.failed, .failed):
                return true
            default:
                return false
            }
        }
    }
    
    // MARK: Properties
    
    @Published var state: State = .loading
    @Published var currentPage: Int = 1
    @Published var totalPages: Int = 1
    @Published var movies: [Movie] = []

    private var genres: [Genre] = []
    private let api: API.Type
    
    // MARK: Initializers
    
    init(api: API.Type = APIRouter.self) {
        self.api = api
    }
}

// MARK: - Networking Methods

extension MoviesListViewModel {
    
    // MARK: Get Genres

    func getGenres() {
        Task {
            do {
                let response = try await self.api.getGenres()
                self.genres = response.genres
                self.getMovies()
            } catch {
                self.state = .failed(error: error, genresFetchingFailed: true)
            }
        }
    }
    
    // MARK: Get Movies
    
    func getMovies() {
        guard self.currentPage <= self.totalPages else { return }
        self.state = .loading
        Task {
            do {
                let response = try await self.api.getMovies(in: self.currentPage)
                self.movies += response.movies
                self.state = .loaded
                self.currentPage += 1
                self.totalPages = response.totalPages
            } catch {
                self.state = .failed(error: error, genresFetchingFailed: false)
            }
        }
    }
}

// MARK: - Data Source

extension MoviesListViewModel {
    
    func getGenres(_ genres: [Int]) -> [String] {
        var genresNames: [String] = []
        genres.forEach { genreId in
            guard let genre = self.genres.first(where: {$0.id == genreId}) else { return }
            genresNames.append(genre.name)
        }
        return genresNames
    }
}
