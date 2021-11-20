//
//  MovieModels.swift
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

enum Movie
{
  // MARK: Use cases
  
  enum FetchMovie {
    struct Request {
    }
    struct Response {
        var movies: MovieResponseModel
    }
    struct ViewModel {
        struct DisplayedMovies {
            var id: Int
            var originalTitle: String
            var overview: String
            var posterPath: String
            var releaseDate: String
            var title: String
        }
        
        var displayedMovies: [DisplayedMovies]
    }
  }
}