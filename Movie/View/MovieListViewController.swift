//
//  MovieListViewController.swift
//  Movie
//
//  Created by Mohamed Farid on 10/07/2024.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: Properties
    
    // MARK: Initializers & Deinitializers
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .themeChanged, object: nil)
    }
    
    // MARK: Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.applyCurrentTheme()
        self.addThemeChangerObserver()
        self.title = String(localized: "movies.screen.title")
    }
}

// MARK: - Theme Handling Methods

extension MovieListViewController {
    
    private func addThemeChangerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(applyCurrentTheme), name: .themeChanged, object: nil)
    }
    
    @objc private func applyCurrentTheme() {
        let theme = ThemeManager.shared.currentTheme
        self.view.backgroundColor = theme.backgroundColor
    }
}
