//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Erva Hatun Tekeoğlu on 20.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Kingfisher

protocol MovieDetailDisplayLogic: class {
    func displayMovieDetail(viewModel: MovieDetail.Movie.ViewModel)
}

class MovieDetailViewController: UIViewController, MovieDetailDisplayLogic {
    var interactor: MovieDetailBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailRoutingLogic & MovieDetailDataPassing)?

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDetail: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        let router = MovieDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
  
  // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetail()
    }
  
    // MARK: Do something
    func fetchMovieDetail() {
        let request = MovieDetail.Movie.Request()
        interactor?.displayMovieDetail(request: request)
    }
  
    func displayMovieDetail(viewModel: MovieDetail.Movie.ViewModel) {
        self.movieName.text = viewModel.displayedMovie.title
        
        let imageUrl = "http://image.tmdb.org/t/p/w500\(viewModel.displayedMovie.posterPath)"
        self.moviePoster.kf.setImage(with: URL(string: imageUrl))
        self.movieDetail.text = viewModel.displayedMovie.overview
        self.movieReleaseDate.text = "Release Date: \(viewModel.displayedMovie.releaseDate)"
    }
}



