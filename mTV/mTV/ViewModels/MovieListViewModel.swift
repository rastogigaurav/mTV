//
//  MovieListViewModel.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

class MovieListViewModel: NSObject {
    
    var movies:[Movie] = []{
        willSet{
            filteredMovies = newValue
        }
    }
    
    var section:MovieSections
    
    var filteredMovies:[Movie] = []
    
    var startDateIndex:Int = years_1950_2017.count-18
    var endDateIndex:Int = years_1950_2017.count-1
    
    var displayMovies:DisplayMoviesProtocol!
    
    init(with displayList:DisplayMoviesProtocol, selectedSection section:MovieSections){
        self.section = section
        self.displayMovies = displayList
    }
    
    func fetchMovies(withPage page:Int, reload:@escaping (_ totalMovies:Int?)->Void){
        self.displayMovies.displayMovies(forSection: self.section, withPage: page) {
            [unowned self] (total,movies,section) in
            if let list = movies{
                self.movies.append(contentsOf: list)
            }
            reload(total)
        }
    }
    
    func filter(basedOn startIndex:Int, endIndex:Int, reload:@escaping ()->())->Void{
        self.displayMovies.filter(movieList: movies, startYear: years_1950_2017[startIndex], endYear: years_1950_2017[endIndex]) {[unowned self] (filteredMovies) in
            self.startDateIndex = startIndex
            self.endDateIndex = endIndex
            self.filteredMovies = filteredMovies
            reload()
        }
    }
    
    func numberOfItemsInSection(section:Int)->Int{
        return self.filteredMovies.count
    }
    
    func titleAndReleaseYearForMovie(at indexPath:IndexPath)->String?{
        if let mTitle = self.filteredMovies[indexPath.row].title{
            return (mTitle + " (" + String(self.filteredMovies[indexPath.row].releaseYear) + ")")
        }
        return nil
    }
    
    func releaseDateForMovie(at indexPath:IndexPath)->String?{
        if let releaseDate = self.filteredMovies[indexPath.row].releaseDate{
            return releaseDate
        }
        return nil
    }
    
    func posterImageUrlForMovie(at indexPath:IndexPath)->String?{
        if let posterImageUrl = self.filteredMovies[indexPath.row].posterPathURL(){
            return posterImageUrl
        }
        return nil
    }
    
    func movieId(forMovieAt indexPath:IndexPath)->Int{
        return (self.filteredMovies[indexPath.row]).id!
    }
    
    func titel()->String?{
        switch self.section {
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        default:
            return nil
        }
    }
}
