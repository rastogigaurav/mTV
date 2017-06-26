//
//  MovieRepository.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/21/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

protocol MoviesRepositoryProtocol:NSObjectProtocol {
    func getTopRatedMovies(page:Int, completionHandler:@escaping(_ totalMovies:Int?, _ movies:[Movie]?,_ error:Error?)->Void) -> Void
    
    func getUpcomingMovies(page:Int, completionHandler:@escaping(_ totalMovies:Int?, _ movies:[Movie]?,_ error:Error?)->Void) -> Void
    
    func getNowPlayingMovies(page:Int, completionHandler:@escaping(_ totalMovies:Int?, _ movies:[Movie]?,_ error:Error?)->Void) -> Void
    
    func getPopularMovies(page:Int, completionHandler:@escaping(_ totalMovies:Int?, _ movies:[Movie]?,_ error:Error?)->Void) -> Void
    
    func searchMovie(withKeyword keyword:String, page:Int, completionHandler:@escaping(_ totalMovies:Int?, _ movies:[Movie]?,_ error:Error?)->Void) -> Void
}

class MoviesRepositoryMock: NSObject,MoviesRepositoryProtocol {
    var getTopRatedMoviesIsCalled:Bool = false
    var getUpcomingMoviesIsCalled:Bool = false
    var getNowPlayingMoviesIsCalled:Bool = false
    var getPopularMoviesIsCalled:Bool = false
    var searchMovieIsCalled:Bool = false
    
    func getTopRatedMovies(page: Int, completionHandler:@escaping (Int?, [Movie]? , Error? ) -> Void) {
        getTopRatedMoviesIsCalled = true
        completionHandler(nil,nil,nil)
    }
    
    func getUpcomingMovies(page: Int, completionHandler:@escaping (Int?, [Movie]?, Error?) -> Void) {
        getUpcomingMoviesIsCalled = true
        completionHandler(nil,nil,nil)
    }
    
    func getNowPlayingMovies(page: Int, completionHandler:@escaping (Int?, [Movie]?, Error?) -> Void) {
        getNowPlayingMoviesIsCalled = true
        completionHandler(nil,nil,nil)
    }
    
    func getPopularMovies(page: Int, completionHandler:@escaping (Int?, [Movie]?, Error?) -> Void) {
        getPopularMoviesIsCalled = true
        completionHandler(nil,nil,nil)
    }
    
    func searchMovie(withKeyword keyword: String, page: Int, completionHandler:@escaping(Int?, [Movie]?, Error?) -> Void) {
        searchMovieIsCalled = true
        completionHandler(nil,nil,nil)
    }
}

class MoviesRepository: NSObject,MoviesRepositoryProtocol {
    func getTopRatedMovies(page: Int, completionHandler:@escaping (Int?, [Movie]?, Error?) -> Void) {
        //https://api.themoviedb.org/3/movie/top_rated?api_key=<<api_key>>&language=en-US&page=1
        let url : String = baseUrl + "/3/movie/top_rated"
        
        let parameters: [String: String] = [
            "api_key":apiKey,
            "language":"en-US",
            "page":String(describing:page)]
        
        NetworkManager.get(url,
                           parameters: parameters as [String : AnyObject],
                           success: {(
                            result: NSDictionary) -> Void in
                            
                            var total = 0
                            if let count = result.value(forKey: "total_results") as? Int{
                                total = count
                            }
                            
                            var movieList = [Movie]()
                            if let list = result.value(forKey: "results") as? [AnyObject]{
                                for item in list{
                                    if let json = item as? Dictionary<String, Any>{
                                        movieList.append(Movie(json:json ))
                                    }
                                }
                            }
                            
                            print ("Api Success : top rated movies are:\n \(movieList)")
                            completionHandler(total,movieList,nil)
        },
                           failure: {(
                            error: NSDictionary?) -> Void in
                            print ("Api Failure : error is:\n \(String(describing: error))")
    
                            completionHandler(nil,nil,error as? Error)
        })
    }
    
    
    func getUpcomingMovies(page: Int, completionHandler:@escaping (Int?, [Movie]?, Error?) -> Void) {
        //https://api.themoviedb.org/3/movie/upcoming?api_key=<<api_key>>&language=en-US&page=1
        
        let url : String = baseUrl + "/3/movie/upcoming"
        
        let parameters: [String: String] = [
            "api_key":apiKey,
            "language":"en-US",
            "page":String(describing:page)]
        
        NetworkManager.get(url,
                           parameters: parameters as [String : AnyObject],
                           success: {(
                            result: NSDictionary) -> Void in
                            var total = 0
                            if let count = result.value(forKey: "total_results") as? Int{
                                total = count
                            }
                            
                            var movieList = [Movie]()
                            if let list = result.value(forKey: "results") as? [AnyObject]{
                                for item in list{
                                    if let json = item as? Dictionary<String, Any>{
                                        movieList.append(Movie(json:json ))
                                    }
                                }
                            }
                            
                            print ("Api Success : top rated movies are:\n \(movieList)")
                            completionHandler(total,movieList,nil)
        },
                           failure: {(
                            error: NSDictionary?) -> Void in
                            print ("Api Failure : error is:\n \(String(describing: error))")
                            
                            completionHandler(nil,nil,error as? Error)
        })

    }
    
    func getNowPlayingMovies(page: Int, completionHandler:@escaping (Int?, [Movie]?, Error?) -> Void) {
        //https://api.themoviedb.org/3/movie/now_playing?api_key=<<api_key>>&language=en-US&page=1
        
        let url : String = baseUrl + "/3/movie/now_playing"
        
        let parameters: [String: String] = [
            "api_key":apiKey,
            "language":"en-US",
            "page":String(describing:page)]
        
        NetworkManager.get(url,
                           parameters: parameters as [String : AnyObject],
                           success: {(
                            result: NSDictionary) -> Void in
                            
                            var total = 0
                            if let count = result.value(forKey: "total_results") as? Int{
                                total = count
                            }
                            
                            var movieList = [Movie]()
                            if let list = result.value(forKey: "results") as? [AnyObject]{
                                for item in list{
                                    if let json = item as? Dictionary<String, Any>{
                                        movieList.append(Movie(json:json ))
                                    }
                                }
                            }
                            
                            print ("Api Success : top rated movies are:\n \(movieList)")
                            completionHandler(total,movieList,nil)
        },
                           failure: {(
                            error: NSDictionary?) -> Void in
                            print ("Api Failure : error is:\n \(String(describing: error))")
                            
                            completionHandler(nil,nil,error as? Error)
        })

    }
    
    func getPopularMovies(page: Int, completionHandler:@escaping (Int?, [Movie]?, Error?) -> Void) {
        //https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1
        
        let url : String = baseUrl + "/3/movie/popular"
        
        let parameters: [String: String] = [
            "api_key":apiKey,
            "language":"en-US",
            "page":String(describing:page)]
        
        NetworkManager.get(url,
                           parameters: parameters as [String : AnyObject],
                           success: {(
                            result: NSDictionary) -> Void in
                            var total = 0
                            if let count = result.value(forKey: "total_results") as? Int{
                                total = count
                            }
                            
                            var movieList = [Movie]()
                            if let list = result.value(forKey: "results") as? [AnyObject]{
                                for item in list{
                                    if let json = item as? Dictionary<String, Any>{
                                        movieList.append(Movie(json:json ))
                                    }
                                }
                            }
                            
                            print ("Api Success : top rated movies are:\n \(movieList)")
                            completionHandler(total,movieList,nil)
        },
                           failure: {(
                            error: NSDictionary?) -> Void in
                            print ("Api Failure : error is:\n \(String(describing: error))")
                            
                            completionHandler(nil,nil,error as? Error)
        })

    }
    
    func searchMovie(withKeyword keyword: String, page: Int, completionHandler: @escaping (Int?, [Movie]?, Error?) -> Void) {
        completionHandler(nil,nil,nil)
    }
}
