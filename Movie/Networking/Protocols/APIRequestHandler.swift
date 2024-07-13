//
//  APIRequestHandler.swift
//  Movie
//
//  Created by Mohamed Farid on 10/07/2024.
//

import Foundation
import Alamofire
import Combine

/// API protocol, The alamofire wrapper
protocol APIRequestHandler: HandleAlamofireResponse {}

// MARK: - Request Methods

extension APIRequestHandler where Self: URLRequestBuilder {
    
    func send<T: CodableInit>(_ decoder: T.Type) async throws -> T {
        let response = await AF.request(self).serializingData().response
        
        guard let httpURLResponse = response.response else {
            throw CustomError.unknown(message: nil, statusCode: nil)
        }
        
        switch response.result {
        case .success(let value):
            return try handleAlamofireResponse(
                decoder: decoder,
                data: value,
                urlrequest: self.urlRequest,
                response: httpURLResponse
            )
        case .failure(let error):
            throw error
        }
    }
}
