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
    
    // MARK: Get Genres Request Test
    
    func testGetGenresRequest() {
        let getGenresRequest = MoviesRouter.getGenres
        
        XCTAssertEqual(getGenresRequest.path, MoviesRouter.genresPath)
        XCTAssertEqual(getGenresRequest.method, .get)
    }
    
    // MARK: Search Movies Request Test
    
    func testSearchMoviesRequest() {
        let page = 2
        let text = "Batman"
        let searchMoviesRequest = MoviesRouter.searchMovies(text: text, page: page)
        
        XCTAssertEqual(searchMoviesRequest.path, MoviesRouter.searchMoviesPath)
        XCTAssertEqual(searchMoviesRequest.method, .get)
        XCTAssertEqual(page, searchMoviesRequest.parameters?[Constants.NetworkingConfigs.pageParameterKey] as? Int)
        XCTAssertEqual(text, searchMoviesRequest.parameters?[MoviesRouter.moviesSearchQueryKey] as? String)
    }
}
