//
//  MovieNetworkWorker.swift
//  MovieList
//
//  Created by Erva Hatun Tekeoğlu on 13.11.2021.
//

import Foundation

class MovieNetworkWorker: MovieListWorkerProtocol {
    
    func fetchMovies(completionHandler: @escaping (() throws -> MovieResponseModel) -> Void) {
        NetworkManager().fetchData(ofURL: MovieRequests.movies) { (data, error) in
            
            if error == nil, let data = data{
                do{
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(MovieResponseModel.self, from: data)
                    NSLog("\(result) ")
                    completionHandler{ return result }
                }catch let error {
                    completionHandler{ throw error }
                }
            }else{
                completionHandler{ throw error! }
            }
        }
    }
}
