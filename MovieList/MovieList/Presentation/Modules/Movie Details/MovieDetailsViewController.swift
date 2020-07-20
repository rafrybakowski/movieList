//
//  MovieDetailsViewController.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit
import RxSwift

class MovieDetailsViewController: UIViewController {
    
    private let favouriteMoviePersistor: FavouriteMoviePersistor
    private let numberFormatterFactory: NumberFormatterFactory
    private let disposeBag = DisposeBag()
    
    private var mainView: MovieDetailsView!
    private var movie: CurrentMovie
    private var favouriteMovies: [Int: CurrentMovie] = [:] {
        didSet {
            updateUI()
        }
    }
    private var isMovieFavourite: Bool{
        return favouriteMovies[movie.id] != nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(movie: CurrentMovie,
         favouriteMoviePersistor: FavouriteMoviePersistor,
         numberFormatterFactory: NumberFormatterFactory = DefaultNumberFormatterFactory()) {
        self.movie = movie
        self.favouriteMoviePersistor = favouriteMoviePersistor
        self.numberFormatterFactory = numberFormatterFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view controller should be initialized from code")
    }
    
    override func loadView() {
        super.loadView()
        let dataSource = MovieDetailsDataSource(movie: movie,
                                                ratingNumberFormatter: numberFormatterFactory.makeRatingNumberFormatter())
        let detailsView = MovieDetailsView(dataSource: dataSource)
        mainView = detailsView
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservables()
        favouriteMovies = favouriteMoviePersistor.favouriteMovies
        updateFavouriteButton()
    }
    
    private func configureObservables() {
        _ = favouriteMoviePersistor.currentFavouritesObservable.subscribe(onNext: { [weak self] favouriteMovies in
            self?.favouriteMovies = favouriteMovies
        }).disposed(by: disposeBag)
    }
    
    private func updateUI() {
        updateFavouriteButton()
    }
    
    private func updateFavouriteButton() {
        let isFavourite = isMovieFavourite
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        let image = isFavourite ? UIImage.starFilledTemplate : UIImage.starEmptyTemplate
        button.setImage(image, for: .normal)
        let menuBarItem = UIBarButtonItem(customView: button)
        _ = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        _ = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        button.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = menuBarItem
    }
    
    @objc
    private func favouriteButtonPressed() {
        let isFavourite = isMovieFavourite
        if isFavourite {
            favouriteMoviePersistor.remove(favouriteMovie: movie)
        } else {
            favouriteMoviePersistor.add(favouriteMovie: movie)
        }
        updateFavouriteButton()
    }
}
