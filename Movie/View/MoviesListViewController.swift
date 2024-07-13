//
//  MoviesListViewController.swift
//  Movie
//
//  Created by Mohamed Farid on 10/07/2024.
//

import UIKit
import Combine

class MoviesListViewController: UIViewController {
    
    // MARK: Properties
    
    private let viewModel: MoviesListViewModel
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private lazy var collectionView = UICollectionView { [weak self] sectionIndex, layoutEnvironment in
        guard let self = self else {
            let size = NSCollectionLayoutSize(widthDimension: .absolute(0), heightDimension: .absolute(0))
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
            return NSCollectionLayoutSection(group: group)
        }
        return self.moviesLayout()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Initializers & Deinitializers
        
    init(api: API.Type) {
        self.viewModel = MoviesListViewModel(api: api)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .themeChanged, object: nil)
    }
    
    // MARK: Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.applyCurrentTheme()
        self.addThemeChangerObserver()
        self.title = String(localized: "movies.screen.title")
        self.addSubviews()
        self.addSubviewsConstraints()
        self.subscribeToViewModelStatePublisher()
        self.viewModel.getMovies()
    }
}

// MARK: - Theme Handling Methods

extension MoviesListViewController {
    
    private func addThemeChangerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(applyCurrentTheme), name: .themeChanged, object: nil)
    }
    
    @objc private func applyCurrentTheme() {
        let theme = ThemeManager.shared.currentTheme
        self.view.backgroundColor = theme.backgroundColor
    }
}

// MARK: - Subscriptions

extension MoviesListViewController {
    
    private func subscribeToViewModelStatePublisher() {
        self.viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                switch self.viewModel.state {
                case .loading:
                    self.handleLoading()
                case .loaded:
                    self.handleLoaded()
                case .failed(let error):
                    self.handleFailed(error)
                }
            }
            .store(in: &self.subscriptions)
    }
}

// MARK: - State Handlers

extension MoviesListViewController {
    
    private func handleLoading() {
        self.showActivityIndicator()
        self.collectionView.isScrollEnabled = false
    }
    
    private func handleLoaded() {
        self.hideActivityIndicator()
        self.collectionView.isScrollEnabled = true
        let sectionsToReload = IndexSet(integer: 1) // Reload only characters section
        if self.collectionView.numberOfSections == 1 {
            self.collectionView.insertSections(sectionsToReload)
        } else {
            self.collectionView.reloadSections(sectionsToReload)
        }
    }
    
    private func handleFailed(_ error: Error) {
        self.hideActivityIndicator()
        self.collectionView.isScrollEnabled = false
        self.showErrorAlert(with: error.localizedDescription)
    }
    
    private func showErrorAlert(with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.viewModel.getMovies()
        }
        alertController.addAction(retryAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Add Subviews

extension MoviesListViewController {
    
    private func addSubviews() {
        
    }
    
    private func addSubviewsConstraints() {
        
    }
}

// MARK: - Activity Indicator

extension MoviesListViewController {
    
    // MARK: Show Activity Indicator
    
    private func showActivityIndicator() {
        self.activityIndicator.startAnimating()
        self.collectionView.backgroundView = self.activityIndicator
    }
    
    // MARK: Hide Activity Indicator
    
    private func hideActivityIndicator() {
        self.collectionView.backgroundView = nil
        self.activityIndicator.stopAnimating()
    }
}

// MARK: - Collection View Layouts

extension MoviesListViewController {
    
    private func moviesLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(40), heightDimension: .absolute(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
}
