//
//  MovieViewController.swift
//  movieList
//
//  Created by Erva Hatun Tekeoğlu on 13.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Kingfisher

protocol MovieDisplayLogic: class {
    func displayFetchMovies(viewModel: Movie.FetchMovie.ViewModel)
    func displayMovieDetail(selectedItem: Int)
}

class MovieViewController: UIViewController, MovieDisplayLogic {
    
   // @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var interactor: MovieBusinessLogic?
    var router: (NSObjectProtocol & MovieRoutingLogic & MovieDataPassing)?

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
        let interactor = MovieInteractor()
        let presenter = MoviePresenter()
        let router = MovieRouter()
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
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }
        fetchMovies()
        collectionView.delegate = self
        collectionView.dataSource = self
        //tableView.delegate = self
        //tableView.dataSource = self
    }
      
      // MARK: Do something
        
    var displayedMovies: [Movie.FetchMovie.ViewModel.DisplayedMovies] = []
      //@IBOutlet weak var nameTextField: UITextField!
      
    func fetchMovies() {
        let request = Movie.FetchMovie.Request()
        interactor?.fetchMovies(request: request)
    }
      
    func displayFetchMovies(viewModel: Movie.FetchMovie.ViewModel){
        displayedMovies = viewModel.displayedMovies
        collectionView.isHidden = false
        collectionView.reloadData()
        //tableView.isHidden = false
        //tableView.reloadData()
    }
    
    func displayMovieDetail(selectedItem: Int) {
        router?.routeToMovieDetail(segue: nil, selectedItem: selectedItem)
    }
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let displayedMovie = displayedMovies[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.movieName.text = displayedMovie.originalTitle
        let imageUrl = "http://image.tmdb.org/t/p/w500\(displayedMovie.posterPath)"
        cell.moviePoster.kf.setImage(with: URL(string: imageUrl))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        displayMovieDetail(selectedItem: indexPath.item)
    }  
}

extension MovieViewController: PinterestLayoutDelegate {
    func collectionView( _ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return 320
      }
}

