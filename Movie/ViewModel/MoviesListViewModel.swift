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
    
    private let api: API.Type
    
    private var movies: [Movie] = []
    private var page = 1
    
    // MARK: Initializers
    
    init(api: API.Type = APIRouter.self) {
        self.api = api
    }
}

// MARK: - Networking Methods

extension MoviesListViewModel {
    
    // MARK: Get Characters
    
    func getMovies() {
        Task {
            do {
                let response = try await self.api.getMovies(in: self.page)
                self.movies += response.movies
                self.state = .loaded
            } catch {
                self.state = .failed(error: error)
            }
        }
    }
}
