//
//  UICollectionView.swift
//  Movie
//
//  Created by Mohamed Farid on 13/07/2024.
//

import UIKit

// MARK: - Initializers

extension UICollectionView {
    convenience init(sectionProvider: @escaping UICollectionViewCompositionalLayoutSectionProvider) {
        let compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        
        self.init(frame: .zero, collectionViewLayout: compositionalLayout)
    }
}

// MARK: - Register Reusable

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ classType: T.Type) {
        let reuseIdentifier = String(describing: T.self)
        
        self.register(classType, forCellWithReuseIdentifier: reuseIdentifier)
    }
}
