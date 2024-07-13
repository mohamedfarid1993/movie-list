//
//  MoviesListViewModelTests.swift
//  MovieTests
//
//  Created by Mohamed Farid on 13/07/2024.
//

import XCTest
import Combine
@testable import Movie

final class MoviesListViewModelTests: XCTestCase {

    // MARK: Properties
    
    var viewModel: MoviesListViewModel!
    var subscriptions: Set<AnyCancellable>!
    
    // MARK: Setup Methods
    
    @MainActor override func setUpWithError() throws {
        self.subscriptions = Set<AnyCancellable>()
        self.viewModel = MoviesListViewModel(api: MockAPI.self)
    }
    
    override func tearDownWithError() throws {
        self.subscriptions = nil
        self.viewModel = nil
    }
}

// MARK: - Test Cases

extension MoviesListViewModelTests {
    
    func testGetDataShouldCallAPI() {
        let expectation = XCTestExpectation()
        
        self.viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { state in
                if case .loaded = state {
                    expectation.fulfill()
                }
            }
            .store(in: &self.subscriptions)
        
        self.viewModel.getGenres()
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetGenres() async {
        self.viewModel.genres =  [
            Genre(id: 1, name: "Action"),
            Genre(id: 2, name: "Adventure"),
            Genre(id: 3, name: "Comedy")
        ]
        
        let genreIds = [1, 3]
        let expectedGenres = ["Action", "Comedy"]
        
        let genres = viewModel.getGenres(genreIds)
        
        XCTAssertEqual(genres, expectedGenres, "Genres names should match expected")
    }
}
