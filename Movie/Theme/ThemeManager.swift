//
//  ThemeManager.swift
//  Movie
//
//  Created by Mohamed Farid on 10/07/2024.
//

import UIKit

class ThemeManager {
    
    static let shared = ThemeManager()
    
    private init() {
        self.loadTheme()
    }
    
    var currentTheme: Theme = lightTheme {
        didSet {
            self.saveTheme()
            self.applyTheme(currentTheme)
        }
    }
}

// MARK: - Theme Management Methods

extension ThemeManager {
    
    private func saveTheme() {
        UserDefaults.standard.set(currentTheme.name, forKey: "selectedTheme")
    }
    
    private func loadTheme() {
        let themeName = UserDefaults.standard.string(forKey: "selectedTheme") ?? lightTheme.name
        self.currentTheme = self.themeByName(themeName) ?? lightTheme
    }
    
    private func themeByName(_ name: String) -> Theme? {
        // To be adjusted if new themes are added
        switch name {
        case "Light":
            return lightTheme
        default:
            return nil
        }
    }
    
    private func applyTheme(_ theme: Theme) {
        NotificationCenter.default.post(name: .themeChanged, object: nil)
    }
}
