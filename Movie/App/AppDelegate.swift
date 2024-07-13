//
//  AppDelegate.swift
//  Movie
//
//  Created by Mohamed Farid on 10/07/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.configureAnalytics()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

// MARK: - Analytics

extension AppDelegate {
    private func configureAnalytics() {
        let analyticsManager = AnalyticsManager.shared
        // Add console analytics to the services and we can also add more analytics services here
        analyticsManager.addService(ConsoleAnalyticsService())
    }
}
