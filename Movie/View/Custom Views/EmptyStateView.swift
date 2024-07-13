//
//  EmptyStateView.swift
//  Movie
//
//  Created by Mohamed Farid on 13/07/2024.
//

import UIKit

class EmptyStateView: UIView {
    
    // MARK: Properties
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = ThemeManager.shared.currentTheme.subtitleColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    // MARK: - Initializers
    
    init(message: String) {
        super.init(frame: .zero)
        self.messageLabel.text = message
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup View Methods

extension EmptyStateView {
    private func setupView() {
        self.addSubview(self.messageLabel)
        
        NSLayoutConstraint.activate([
            self.messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            self.messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            self.messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16)
        ])
    }
    
    func setMessage(_ message: String) {
        self.messageLabel.text = message
    }
}
