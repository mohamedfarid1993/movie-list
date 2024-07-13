//
//  MovieCell.swift
//  Movie
//
//  Created by Mohamed Farid on 13/07/2024.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static let reuseIdentifier = "MovieCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        label.textColor = ThemeManager.shared.currentTheme.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = ThemeManager.shared.currentTheme.subtitleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = ThemeManager.shared.currentTheme.secondaryColor
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup View Methods

extension MovieCell {
    
    private func setupViews() {
        self.contentView.addSubview(movieImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(yearLabel)
        self.contentView.addSubview(genreLabel)
        self.movieImageView.layer.cornerRadius = 8
        self.movieImageView.clipsToBounds = true
        self.addConstraints()
    }
    
    private func addConstraints() {
        // Add constraints for layout
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
            
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            yearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            genreLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 4),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    func configure(with movie: Movie, genres: [String]) {
        self.titleLabel.text = movie.title
        ImageProvider.loadImage(with: movie.posterPathURL, into: self.movieImageView)
        if let productionYear = movie.productionYear {
            yearLabel.text = productionYear
        } else {
            yearLabel.text = "N/A"
        }
        self.genreLabel.text = genres.joined(separator: ", ") + "."
    }
}
