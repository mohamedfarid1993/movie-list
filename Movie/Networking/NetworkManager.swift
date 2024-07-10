//
//  NetworkManager.swift
//  Movie
//
//  Created by Mohamed Farid on 10/07/2024.
//

import Foundation
import Alamofire

enum NetworkManager {
    static let session: Session = { // One session to be used across the app
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        return Session(configuration: configuration)
    }()
}
