//
//  NetworkLayerTest.swift
//  MovieTests
//
//  Created by Mohamed Farid on 13/07/2024.
//

import XCTest
import Alamofire
@testable import Movie

class NetworkLayerTest: XCTestCase, HandleAlamofireResponse {
    
    // MARK: Handle Alamofire Response Tests
    
    func testSuccessAlamofireResponse() async {
        guard let urlFromString = URL(string: "https://fakeURL.com") else {
            XCTFail("URL From String failed")
            return
        }
        let fakeUrlRequest = URLRequest(url: urlFromString)
        guard let url = fakeUrlRequest.url else {
            XCTFail("URL is null")
            return
        }
        guard let fakeResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            XCTFail("Fake Response is null")
            return
        }
        guard
            let moviesData = try? JSONEncoder().encode(MoviesResponse.fake()),
            let moviesResponse = try? self.handleAlamofireResponse(decoder: MoviesResponse.self,
                                                                       data: moviesData,
                                                                       urlrequest: fakeUrlRequest,
                                                                       response: fakeResponse)
        else { assertionFailure(); return }
        let moviesRequestResponse = try? await MockAPI.getMovies(in: 1)
        XCTAssertEqual(moviesRequestResponse?.movies.first?.id, moviesResponse.movies.first?.id)
    }
    
    func testDecodingFailure() {
        guard let urlFromString = URL(string: "https://fakeURL.com") else {
            XCTFail("URL From String failed")
            return
        }
        let fakeUrlRequest = URLRequest(url: urlFromString)
        guard let url = fakeUrlRequest.url else {
            XCTFail("URL is null")
            return
        }
        guard let fakeResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            XCTFail("Fake Response is null")
            return
        }
        guard
            let moviesData = try? JSONEncoder().encode(MoviesResponse.fake())
        else { assertionFailure(); return }
        do {
            _ = try self.handleAlamofireResponse(decoder: MoviesResponse.self,
                                                 data: moviesData,
                                                 urlrequest: fakeUrlRequest,
                                                 response: fakeResponse)
        } catch {
            XCTAssertEqual(error.localizedDescription, CustomError.decoding.errorDescription)
        }
    }
}

// MARK: - Request Builder & Handler Tests

extension NetworkLayerTest {
    
    // MARK: Test URL Request Builder
    
    func testRequestBuilder() {
        let request = MoviesRouter.getPopularMovies(page: 1)
        XCTAssertTrue(request.mainURL.contains(Constants.NetworkingConfigs.baseURL))
        XCTAssertEqual(
            request.headers[Constants.NetworkingConfigs.acceptHeaderKey],
            Constants.NetworkingConfigs.acceptHeaderValue
        )
        XCTAssertEqual(request.urlRequest.cachePolicy, .reloadIgnoringLocalCacheData)
        XCTAssertTrue(((request.parameters?.contains(where: { $0.key == Constants.NetworkingConfigs.apiKey })) != nil))
    }
}
