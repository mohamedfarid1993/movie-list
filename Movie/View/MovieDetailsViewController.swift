//
//  MovieDetailsViewController.swift
//  Movie
//
//  Created by Mohamed Farid on 13/07/2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let movie: Movie
    private let genres: [String]
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let movieImageView = UIImageView()
    private let titleLabel = UILabel()
    private let overviewLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let genresLabel = UILabel()
    private let ratingLabel = UILabel()
    private let voteCountLabel = UILabel()
    
    // MARK: Initializers
    
    init(movie: Movie, genres: [String]) {
        self.movie = movie
        self.genres = genres
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .themeChanged, object: nil)
    }
    
    // MARK: Life Cycle View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.applyCurrentTheme()
        self.addThemeChangerObserver()
        self.setupScrollView()
        self.setupViews()
        self.configureViews()
    }
}

// MARK: - Theme Handling Methods

extension MovieDetailsViewController {
    
    private func addThemeChangerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(applyCurrentTheme), name: .themeChanged, object: nil)
    }
    
    @objc private func applyCurrentTheme() {
        let theme = ThemeManager.shared.currentTheme
        self.view.backgroundColor = theme.backgroundColor
        self.scrollView.backgroundColor = theme.backgroundColor
    }
}

// MARK: - Scroll View Methods

extension MovieDetailsViewController {
    
    private func setupScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        self.scrollView.addSubview(contentView)
        self.setupContentView()
    }
    
    private func setupContentView() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    }
}

// MARK: - Setup Views Methods

extension MovieDetailsViewController {
    
    private func setupViews() {
        self.setupMovieImageView()
        self.setupTitleLabel()
        self.setupReleaseDateLabel()
        self.setupGenresLabel()
        self.setupRatingLabel()
        self.setupVoteCountLabel()
        self.setupOverviewLabel()
    }
    
    private func setupMovieImageView() {
        self.contentView.addSubview(self.movieImageView)
        self.movieImageView.translatesAutoresizingMaskIntoConstraints = false
        self.movieImageView.contentMode = .scaleAspectFill
        self.movieImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            self.movieImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.movieImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.movieImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.movieImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 1.5)
        ])
    }
    
    private func setupTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.titleLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.movieImageView.bottomAnchor, constant: 16),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupReleaseDateLabel() {
        self.contentView.addSubview(self.releaseDateLabel)
        self.releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.releaseDateLabel.font = UIFont.systemFont(ofSize: 16)
        self.releaseDateLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            self.releaseDateLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.releaseDateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.releaseDateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupGenresLabel() {
        self.contentView.addSubview(self.genresLabel)
        self.genresLabel.translatesAutoresizingMaskIntoConstraints = false
        self.genresLabel.font = UIFont.systemFont(ofSize: 16)
        self.genresLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            self.genresLabel.topAnchor.constraint(equalTo: self.releaseDateLabel.bottomAnchor, constant: 8),
            self.genresLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.genresLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupRatingLabel() {
        self.contentView.addSubview(self.ratingLabel)
        self.ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.ratingLabel.font = UIFont.systemFont(ofSize: 16)
        self.ratingLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            self.ratingLabel.topAnchor.constraint(equalTo: self.genresLabel.bottomAnchor, constant: 8),
            self.ratingLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.ratingLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupVoteCountLabel() {
        self.contentView.addSubview(self.voteCountLabel)
        self.voteCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.voteCountLabel.font = UIFont.systemFont(ofSize: 16)
        self.voteCountLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            self.voteCountLabel.topAnchor.constraint(equalTo: self.ratingLabel.bottomAnchor, constant: 8),
            self.voteCountLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.voteCountLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupOverviewLabel() {
        self.contentView.addSubview(self.overviewLabel)
        self.overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        self.overviewLabel.font = UIFont.systemFont(ofSize: 16)
        self.overviewLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            self.overviewLabel.topAnchor.constraint(equalTo: self.voteCountLabel.bottomAnchor, constant: 8),
            self.overviewLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.overviewLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.overviewLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
    }
    
    private func configureViews() {
        self.titleLabel.text = self.movie.title
        self.configureReleaseDataTitle()
        self.configureGenresTitle()
        self.configureRatingTitle()
        self.configureVotingTitle()
        self.configureOverviewTitle()
        ImageProvider.loadImage(with: self.movie.posterPathURL, into: self.movieImageView)
    }
    
    private func configureReleaseDataTitle() {
        let releaseDateBoldText = "Release Date:"
        let releaseDateText = self.movie.releaseDate
        let attributedString = NSMutableAttributedString(string: "\(releaseDateBoldText) \(releaseDateText)")
        
        let range = (attributedString.string as NSString).range(of: releaseDateBoldText)
        let semiBoldFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        attributedString.addAttribute(.font, value: semiBoldFont, range: range)
        
        self.releaseDateLabel.attributedText = attributedString
    }
    
    private func configureGenresTitle() {
        let genresBoldText = "Genres:"
        let genresText = " \(self.genres.joined(separator: ", "))"
        let attributedString = NSMutableAttributedString(string: "\(genresBoldText) \(genresText)")
        
        let range = (attributedString.string as NSString).range(of: genresBoldText)
        let semiBoldFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        attributedString.addAttribute(.font, value: semiBoldFont, range: range)
        
        self.genresLabel.attributedText = attributedString
    }
    
    private func configureRatingTitle() {
        let ratingBoldText = "Rating:"
        let ratingText = " \(self.movie.voteAverage)"
        let attributedString = NSMutableAttributedString(string: "\(ratingBoldText) \(ratingText)")
        
        let range = (attributedString.string as NSString).range(of: ratingBoldText)
        let semiBoldFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        attributedString.addAttribute(.font, value: semiBoldFont, range: range)
        
        self.ratingLabel.attributedText = attributedString
    }
    
    private func configureVotingTitle() {
        let votingBoldText = "Vote Count:"
        let votingText = " \(self.movie.voteCount)"
        let attributedString = NSMutableAttributedString(string: "\(votingBoldText) \(votingText)")
        
        let range = (attributedString.string as NSString).range(of: votingBoldText)
        let semiBoldFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        attributedString.addAttribute(.font, value: semiBoldFont, range: range)
        
        self.voteCountLabel.attributedText = attributedString
    }
    
    private func configureOverviewTitle() {
        let overviewBoldText = "Overview:"
        let overviewText = " \(self.movie.overview)"
        let attributedString = NSMutableAttributedString(string: "\(overviewBoldText) \(overviewText)")
        
        let range = (attributedString.string as NSString).range(of: overviewBoldText)
        let semiBoldFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        attributedString.addAttribute(.font, value: semiBoldFont, range: range)
        
        self.overviewLabel.attributedText = attributedString
    }
}
