//
//  MovieDetailInteractor.swift
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

protocol MovieDetailBusinessLogic {
    func displayMovieDetail(request: MovieDetail.Movie.Request)
}

protocol MovieDetailDataStore {
    var movie: Result? {get set}
}

class MovieDetailInteractor: MovieDetailBusinessLogic, MovieDetailDataStore {
    var presenter: MovieDetailPresentationLogic?
    var worker: MovieDetailWorker?
    var movie: Result?
  
    // MARK: Do something
    func displayMovieDetail(request: MovieDetail.Movie.Request) {
        //worker = MovieDetailWorker()
        //worker?.doSomeWork()
        let response = MovieDetail.Movie.Response(movie: self.movie!)
        presenter?.presentMovieDetail(response: response)
    }
}
