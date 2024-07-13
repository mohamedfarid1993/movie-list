//
//  AnalyticsManager.swift
//  Movie
//
//  Created by Mohamed Farid on 13/07/2024.
//

import Foundation

class AnalyticsManager {
    static let shared = AnalyticsManager()
    private var services: [AnalyticsService] = []
    
    private init() {}
    
    func addService(_ service: AnalyticsService) {
        services.append(service)
    }
    
    func trackEvent(name: String, properties: [String: Any]? = nil) {
        services.forEach { $0.trackEvent(name: name, properties: properties) }
    }
    
    func identifyUser(userId: String, properties: [String: Any]? = nil) {
        services.forEach { $0.identifyUser(userId: userId, properties: properties) }
    }
    
    func setUserProperty(name: String, value: Any) {
        services.forEach { $0.setUserProperty(name: name, value: value) }
    }
}
