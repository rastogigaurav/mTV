//
//  DisplayMovies.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/22/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

protocol DisplayMoviesProtocol:NSObjectProtocol{
    func displayMovies(forSection section:MovieSections, withPage page:Int, completionHandler:@escaping (_ totalMovies:Int?, _ movies:[Movie]?, _ section:MovieSections?)->())->Void
    
    func filter(movieList list:[Movie], startYear sYear:Int, endYear eYear:Int, completionHandler:@escaping (_ filteredList:[Movie])->Void)->Void
}

class DisplayMoviesMock:NSObject,DisplayMoviesProtocol{
    var displayMoviesIsCalled = false
    var filterMovieListIsCalled:Bool = false
    
    func displayMovies(forSection section: MovieSections, withPage page: Int, completionHandler: @escaping (Int?, [Movie]?, MovieSections?) -> ()) {
        displayMoviesIsCalled = true
        completionHandler(0, [Movie(json: Dictionary())], section)
    }
    
    func filter(movieList list: [Movie], startYear sYear: Int, endYear eYear: Int, completionHandler: @escaping ([Movie]) -> Void) {
        filterMovieListIsCalled = true
        completionHandler([Movie(json: Dictionary())])
    }
}

class DisplayMovies: NSObject,DisplayMoviesProtocol {
    
    var moviesRepository:MoviesRepositoryProtocol?
    
    init(with mRespository:MoviesRepositoryProtocol) {
        super.init()
        self.moviesRepository = mRespository
    }
    
    func displayMovies(forSection section: MovieSections, withPage page: Int, completionHandler: @escaping (Int?, [Movie]?, MovieSections?) -> ()) {
        switch section {
        case .topRated:
            self.moviesRepository?.getTopRatedMovies(page: page, completionHandler: { (total, movies, error) in
                if error == nil{
                    completionHandler(total,movies,section)
                }
            })
            break
        case .upcoming:
            self.moviesRepository?.getUpcomingMovies(page: page, completionHandler: { (total, movies, error) in
                if error == nil{
                    completionHandler(total,movies,section)
                }
            })
            break
        case .nowPlaying:
            self.moviesRepository?.getNowPlayingMovies(page: page, completionHandler: { (total, movies, error) in
                if error == nil{
                    completionHandler(total,movies,section)
                }
            })
            break
        case .popular:
            self.moviesRepository?.getPopularMovies(page: page, completionHandler: { (total, movies, error) in
                if error == nil{
                    completionHandler(total,movies,section)
                }
            })
            break
        default:break
        }
    }
    
    func filter(movieList list: [Movie], startYear sYear: Int, endYear eYear: Int, completionHandler: @escaping ([Movie]) -> Void) {
        let filteredList = list.filter { ($0.releasedBetween(startYear: sYear, endYear: eYear))}
        completionHandler(filteredList)
    }
}



