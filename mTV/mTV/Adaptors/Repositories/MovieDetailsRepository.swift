//
//  MovieDetailsRepository.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

protocol MovieDetailsRepositoryProtocol:NSObjectProtocol {
    func getDetails(forMovieWith id:Int, completionHandler:@escaping(_ movie:Movie?, _ error:Error?)->Void)->Void
}

class MovieDetailsRepositoryMock: NSObject, MovieDetailsRepositoryProtocol {
    var getMovieDetailsIsCalled = false
    func getDetails(forMovieWith id: Int, completionHandler: @escaping (Movie?, Error?) -> Void) {
        self.getMovieDetailsIsCalled = true
        completionHandler(nil,nil)
    }
}

class MovieDetailsRepository: NSObject,MovieDetailsRepositoryProtocol {
    func getDetails(forMovieWith id: Int, completionHandler: @escaping (Movie?, Error?) -> Void) {
        //https://api.themoviedb.org/3/movie/{movie_id}?api_key=<<api_key>>&language=en-US
        
        let url : String = baseUrl + "/3/movie/" + String(id)
        
        let parameters: [String: String] = [
            "api_key":apiKey,
            "language":"en-US"]
        NetworkManager.get(url,
                           parameters: parameters as [String : AnyObject],
                           success: {(result) -> Void in
                            let movie = Movie(json: result as! Dictionary<String, Any>)
                            print ("Api Success : Movies detail are:\n \(movie)")
                            completionHandler(movie,nil)
        },
                           failure: {(error: NSDictionary?) -> Void in
                            print ("Api Failure : error is:\n \(String(describing: error))")
                            completionHandler(nil,error as? Error)
        })
    }
}
