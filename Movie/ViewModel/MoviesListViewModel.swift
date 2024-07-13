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
        case loading, loaded, failed(error: Error)
        
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

    private let api: API.Type
    
    // MARK: Initializers
    
    init(api: API.Type = APIRouter.self) {
        self.api = api
    }
}

// MARK: - Networking Methods

extension MoviesListViewModel {
    
    // MARK: Get Characters
    
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
                self.state = .failed(error: error)
            }
        }
    }
}
