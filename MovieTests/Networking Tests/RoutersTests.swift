//
//  RoutersTests.swift
//  MovieTests
//
//  Created by Mohamed Farid on 13/07/2024.
//

@testable import Movie
import XCTest

// MARK: - Movies Router Tests

class RoutersTests: XCTestCase {
    
    // MARK: Get Movies Request Test
    
    func testGetMoviesRequest() {
        let page = 2
        let getMoviesRequest = MoviesRouter.getPopularMovies(page: page)
        
        XCTAssertEqual(getMoviesRequest.path, MoviesRouter.moviesPath)
        XCTAssertEqual(getMoviesRequest.method, .get)
        XCTAssertEqual(page, getMoviesRequest.parameters?[Constants.NetworkingConfigs.pageParameterKey] as? Int)
    }
}
