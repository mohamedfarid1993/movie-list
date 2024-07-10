//
//  SceneDelegate.swift
//  Movie
//
//  Created by Mohamed Farid on 10/07/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.setRootViewController()
    }
}

// MARK: - Navigation Methods

extension SceneDelegate {
    
    func setRootViewController() {
        let movieListViewController = MovieListViewController()
        let navigationController = UINavigationController(rootViewController: movieListViewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
