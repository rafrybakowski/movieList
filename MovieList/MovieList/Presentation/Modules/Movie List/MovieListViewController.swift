//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit
import RxSwift

protocol MovieListViewControllerDelegate: AnyObject {
    func movieDetailsViewControllerDidRequest(detailsFor movie: CurrentMovie)
}

class MovieListViewController: UIViewController {
    
    private let currentlyPlayingSynchronizer: CurrentlyPlayingSynchronizer
    private let searchMoviesSynchronizer: SearchMoviesSynchronizer
    private let favouriteMoviePersistor: FavouriteMoviePersistor
    private let numberFormatterFactory: NumberFormatterFactory
    private let disposeBag = DisposeBag()
    
    private var mainView: MovieListView!
    private var searchResultsView: MovieListView!
    private var searchToggleButton: UIButton!
    private var currentMovies: [CurrentMovie] = [] {
        didSet {
            reloadMainViewData()
        }
    }
    private var searchResultsMovies: [CurrentMovie] = [] {
        didSet {
            reloadSearchResultsData()
        }
    }
    private var favouriteMovies: [Int: CurrentMovie] = [:] {
        didSet {
            reloadMainViewData()
            reloadSearchResultsData()
        }
    }
    
    private var currentMoviesSyncing: Bool = false {
        didSet {
            // Here we could add a loading indicator, future improvement
        }
    }
    
    weak var delegate: MovieListViewControllerDelegate?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(currentlyPlayingSynchronizer: CurrentlyPlayingSynchronizer,
         searchMoviesSynchronizer: SearchMoviesSynchronizer,
         favouriteMoviePersistor: FavouriteMoviePersistor,
         numberFormatterFactory: NumberFormatterFactory = DefaultNumberFormatterFactory()) {
        self.currentlyPlayingSynchronizer = currentlyPlayingSynchronizer
        self.searchMoviesSynchronizer = searchMoviesSynchronizer
        self.favouriteMoviePersistor = favouriteMoviePersistor
        self.numberFormatterFactory = numberFormatterFactory
        super.init(nibName: nil, bundle: nil)
        
        self.favouriteMovies = favouriteMoviePersistor.favouriteMovies
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view controller should be initialized from code")
    }
    
    override func loadView() {
        super.loadView()
        loadMainView()
        loadSearchResultsView()
    }
    
    private func loadMainView() {
        let dataSource = MovieListDataSource(ratingNumberFormatter: numberFormatterFactory.makeRatingNumberFormatter())
        let listView = MovieListView(dataSource: dataSource)
        listView.delegate = self
        mainView = listView
        view = mainView
    }
    
    private func loadSearchResultsView() {
        let dataSource = MovieListDataSource(ratingNumberFormatter: numberFormatterFactory.makeRatingNumberFormatter())
        let listView = MovieListView(dataSource: dataSource)
        listView.delegate = self
        searchResultsView = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Currently playing"
        
        configureObservables()
        setupNavigationBarItems()
        currentlyPlayingSynchronizer.fetchMoreData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        layoutNavigationBarIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layoutNavigationBarIfNeeded()
    }
    
    private func layoutNavigationBarIfNeeded() {
        navigationController?.view.setNeedsLayout()
        navigationController?.view.layoutIfNeeded()
    }
    
    private func configureObservables() {
        _ = currentlyPlayingSynchronizer.currentlyPlayingObservable.subscribe(onNext: { [weak self] currentMovies in
            self?.currentMovies = currentMovies
        }).disposed(by: disposeBag)
        
        _ = currentlyPlayingSynchronizer.synchronizationStatusObservable.subscribe(onNext: { [weak self] isSyncing in
            self?.currentMoviesSyncing = isSyncing
        }).disposed(by: disposeBag)
        
        _ = searchMoviesSynchronizer.searchMoviesObservable.subscribe(onNext: { [weak self] searchResultsMovies in
            self?.searchResultsMovies = searchResultsMovies
        }).disposed(by: disposeBag)
        
        _ = favouriteMoviePersistor.currentFavouritesObservable.subscribe(onNext: { [weak self] favouriteMovies in
            self?.favouriteMovies = favouriteMovies
        }).disposed(by: disposeBag)
    }
    
    private func setupNavigationBarItems() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 60, height: 30)
        button.setTitle("Search", for: .normal)
        searchToggleButton = button
        let menuBarItem = UIBarButtonItem(customView: button)
        
        button.addTarget(self, action: #selector(toggleSearch), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = menuBarItem
    }
    
    private func reloadMainViewData() {
        mainView.load(items: currentMovies, favouriteItems: favouriteMovies)
    }
    
    private func reloadSearchResultsData() {
        searchResultsView.load(items: searchResultsMovies, favouriteItems: favouriteMovies)
    }

    @objc
    private func toggleSearch() {
        if navigationItem.titleView is UISearchBar {
            showCurrentlyPlayedUI()
        } else {
            showSearchUI()
        }
    }
    
    private func showCurrentlyPlayedUI() {
        hideKeyboard()
        navigationItem.titleView = nil
        searchToggleButton.setTitle("Search", for: .normal)
        searchResultsMovies = []
        
        view = mainView
    }
    
    private func showSearchUI() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Enter movie title"
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.barStyle = .default
        if #available(iOS 13, *) {
            searchBar.searchTextField.backgroundColor = .mvWhite
            searchBar.searchTextField.textColor = .mvText
        }
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
        searchToggleButton.setTitle("Cancel", for: .normal)
        
        view = searchResultsView
    }
    
    private func getMovie(for list: MovieListView, with indexPath: IndexPath) -> CurrentMovie {
        if list == mainView {
            return currentMovies[indexPath.row]
        } else {
            return searchResultsMovies[indexPath.row]
        }
    }
    
    private func hideKeyboard() {
        navigationItem.titleView?.resignFirstResponder()
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMoviesSynchronizer.search(query: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if (searchBar.text ?? "").isEmpty {
            toggleSearch()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension MovieListViewController: MovieListViewDelegate {
    func movieListView(movieListView: MovieListView, didSelectItemAt indexPath: IndexPath) {
        let movie = getMovie(for: movieListView, with: indexPath)
        hideKeyboard()
        delegate?.movieDetailsViewControllerDidRequest(detailsFor: movie)
    }
    
    func movieListView(movieListView: MovieListView, favouriteSelectedAt indexPath: IndexPath) {
        let movie = getMovie(for: movieListView, with: indexPath)
        if favouriteMovies[movie.id] == nil {
            favouriteMoviePersistor.add(favouriteMovie: movie)
        } else {
            favouriteMoviePersistor.remove(favouriteMovie: movie)
        }
    }
    
    func movieListViewDidRequestMoreData(movieListView: MovieListView) {
        // Due to time limitations, paging implemented only for
        if movieListView == mainView && !currentMoviesSyncing {
            currentlyPlayingSynchronizer.fetchMoreData()
        }
    }
    
    func movieListViewWillBeginDragging() {
        hideKeyboard()
    }
}
