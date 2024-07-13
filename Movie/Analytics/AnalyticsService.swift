//
//  AnalyticsService.swift
//  Movie
//
//  Created by Mohamed Farid on 13/07/2024.
//

import Foundation

protocol AnalyticsService {
    func trackEvent(name: String, properties: [String: Any]?)
    func identifyUser(userId: String, properties: [String: Any]?)
    func setUserProperty(name: String, value: Any)
}
