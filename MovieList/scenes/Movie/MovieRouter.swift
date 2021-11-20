//
//  MovieRouter.swift
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

@objc protocol MovieRoutingLogic
{
    func routeToMovieDetail(segue: UIStoryboardSegue?, selectedItem: Int)
}

protocol MovieDataPassing
{
  var dataStore: MovieDataStore? { get }
}

class MovieRouter: NSObject, MovieRoutingLogic, MovieDataPassing
{
  weak var viewController: MovieViewController?
  var dataStore: MovieDataStore?
  
  // MARK: Routing
    func routeToMovieDetail(segue: UIStoryboardSegue?, selectedItem: Int)  {
        let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataMovieDetail(source: dataStore!, destination: &destinationDS, selectedItem: selectedItem)
        navigateToUpcomingMovieDetail(source: viewController!, destination: destinationVC)
        
    }
    
    // MARK: Navigation
    
    func navigateToUpcomingMovieDetail(source: MovieViewController, destination: MovieDetailViewController)
    {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataMovieDetail(source: MovieDataStore, destination: inout MovieDetailDataStore, selectedItem: Int)
    {
        //let selectedItem = viewController?.collectionView.cellForItem(at: IndexPath)
        
        
        destination.movie = source.movies?.results[selectedItem]
    }
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: MovieViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: MovieDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
