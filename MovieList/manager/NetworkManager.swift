//
//  NetworkManager.swift
//  MovieList
//
//  Created by Erva Hatun Tekeoğlu on 13.11.2021.
//

import Foundation
import Alamofire

public enum MovieRequests: URLRequestConvertible {
    
    static let baseURLPath = "https://api.themoviedb.org/3"
    static let apiKey = "ae7a88338c64c481907e5864e8b3eddc"
    
    //let url = "https://api.themoviedb.org/3/discover/movie?api_key=ae7a88338c64c481907e5864e8b3eddc"
    //let url = "https://api.themoviedb.org/3/movie/upcoming?api_key=1f54bd990f1cdfb230adb312546d765d/fzKWwcaam9QSTaMSJlORuSojxio.jpg"
    case movies
    case movieDetail(String)
    
    var path: String {
        switch self {
        case .movies: return "/discover/movie"
        case .movieDetail(let movieId): return movieId
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .movies: return ["api_key": MovieRequests.apiKey,"language":"en-US"]
        case .movieDetail: return ["api_key": MovieRequests.apiKey]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        
        let url = try MovieRequests.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = "GET"
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}

class NetworkManager {
    
    func fetchData(ofURL url:URLRequestConvertible, callback:@escaping (Data?,Error?)->Void) {
        
        AF.request(url).validate().responseJSON { response in
            
            NSLog("Requesting: \(url.urlRequest!)")
            
            switch response.result {
            case .success:
                let data = response.data
                NSLog("Request successed!")
                callback(data, nil)
            case .failure(let error):
                NSLog("Request failed! \(error.localizedDescription)")
                callback(nil, error)
            }
        }
    }
}
