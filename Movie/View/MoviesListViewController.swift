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
    private var dataSource: UICollectionViewDiffableDataSource<Int, Movie>!
    private var collectionView: UICollectionView!
    private var searchController: UISearchController!

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
        
        self.title = String(localized: "movies.screen.title")
        
        self.applyCurrentTheme()
        self.addThemeChangerObserver()
        self.addSubviews()
        self.subscribeToViewModelStatePublisher()
        self.viewModel.getGenres()
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
        guard let collectionView = collectionView else { return }
        collectionView.reloadData()
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
                case .loaded(let isSearching):
                    isSearching ? self.handleLoadedSearch() : self.handleLoaded()
                case .failed(let error, let genresFetchingFailed):
                    self.handleFailed(error, genresFetchingFailed)
                }
            }
            .store(in: &self.subscriptions)
    }
}

// MARK: - State Handlers

extension MoviesListViewController {
    
    private func handleLoading() {
        guard self.viewModel.currentPage == 1 else { return }
        self.showActivityIndicator()
        self.collectionView.isScrollEnabled = false
    }
    
    private func handleLoaded() {
        self.hideActivityIndicator()
        self.collectionView.isScrollEnabled = true
        var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
        if self.viewModel.currentPage > 2 {
            snapshot = self.dataSource.snapshot()
            let existingMovies = snapshot.itemIdentifiers
            let newMovies = self.viewModel.movies.filter { !existingMovies.contains($0) }
            snapshot.appendItems(newMovies)
        } else {
            snapshot.appendSections([0])
            snapshot.appendItems(self.viewModel.movies)
        }
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func handleLoadedSearch() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
        if self.viewModel.currentSearchedPage > 2 {
            snapshot = self.dataSource.snapshot()
            let existingMovies = snapshot.itemIdentifiers
            let newMovies = self.viewModel.searchedMovies.filter { !existingMovies.contains($0) }
            snapshot.appendItems(newMovies)
        } else {
            snapshot.appendSections([0])
            snapshot.appendItems(self.viewModel.searchedMovies)
        }
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func handleFailed(_ error: Error, _ genresFetchingFailed: Bool) {
        self.hideActivityIndicator()
        self.collectionView.isScrollEnabled = false
        self.showErrorAlert(with: error.localizedDescription, genresFetchingFailed)
    }
    
    private func showErrorAlert(with message: String, _ genresFetchingFailed: Bool) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            genresFetchingFailed ? self?.viewModel.getGenres() : self?.viewModel.getMovies()
        }
        alertController.addAction(retryAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Add Subviews

extension MoviesListViewController {
    
    private func addSubviews() {
        self.setupCollectionView()
        self.setupSearchController()
    }
}

// MARK: - Search Controller Setup

extension MoviesListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    private func setupSearchController() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = String(localized: "Search Movies")
        self.searchController.searchBar.delegate = self
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.isEmpty {
            self.viewModel.isSearching = false
            self.updateSnapshot(with: self.viewModel.movies)
        } else {
            self.viewModel.isSearching = true
            self.viewModel.searchMovies(with: searchText)
        }
    }
    
    private func updateSnapshot(with movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
        snapshot.appendSections([0])
        snapshot.appendItems(movies)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.isSearching = false
        self.updateSnapshot(with: self.viewModel.movies)
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

// MARK: - Collection View Setup

extension MoviesListViewController {
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            return self.moviesLayout()
        }
        
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        self.collectionView.delegate = self
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        self.view.addSubview(self.collectionView)
        
        self.dataSource = UICollectionViewDiffableDataSource<Int, Movie>(collectionView: self.collectionView) { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
            cell.configure(with: movie, genres: self.viewModel.getGenres(movie.genreIDS))
            return cell
        }
    }
    
    private func moviesLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        section.orthogonalScrollingBehavior = .none

        section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, contentOffset, environment) in
            guard let self = self else { return }
            if let lastItem = visibleItems.last,
               lastItem.indexPath.row == self.viewModel.movies.count - 1,
               self.viewModel.state != .loading {
                if self.viewModel.isSearching, let text = self.searchController.searchBar.text {
                    self.viewModel.searchMovies(with: text)
                } else {
                    self.viewModel.getMovies()
                }
            }
        }

        return section
    }
}

// MARK: - Collection View Delegate Methods

extension MoviesListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.itemIdentifier(for: indexPath) else { return }
        
        let movieDetailsViewController = MovieDetailsViewController(movie: movie,
                                                                    genres: self.viewModel.getGenres(movie.genreIDS))
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
