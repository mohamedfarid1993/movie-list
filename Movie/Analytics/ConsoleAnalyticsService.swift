//
//  ConsoleAnalyticsService.swift
//  Movie
//
//  Created by Mohamed Farid on 13/07/2024.
//

import Foundation

class ConsoleAnalyticsService: AnalyticsService {
    func trackEvent(name: String, properties: [String: Any]?) {
        print(name, properties as Any)
    }

    func identifyUser(userId: String, properties: [String: Any]?) {
        print(userId, properties as Any)
    }

    func setUserProperty(name: String, value: Any) {
        print(name, value as Any)
    }
}
