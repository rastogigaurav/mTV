//
//  HomeViewModel.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/22/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

enum MovieSections:Int {
    case topRated=0,
    upcoming,
    nowPlaying,
    popular,
    totalOrUnknown
}

class HomeViewModel: NSObject {
    var topRatedMovies:[Movie]?
    var upcomingMovies:[Movie]?
    var nowPlayingMovies:[Movie]?
    var popularMovies:[Movie]?
    
    var displayMovies:DisplayMoviesProtocol
    var reloadSection:((_ section:MovieSections?)->Void) = {_ in }
    
    var currentPage = 1
    
    init(with displayMovies:DisplayMoviesProtocol) {
        self.displayMovies = displayMovies
    }
    
    func fetchMovies(){
        self.displayMovies.displayMovies(forSection: .topRated, withPage: currentPage) {[unowned self] (total,movies,section) in
            self.topRatedMovies = movies
            self.reloadSection(section)
        }
        
        self.displayMovies.displayMovies(forSection: .upcoming, withPage: currentPage) {[unowned self] (total,movies,section) in
            self.upcomingMovies = movies
            self.reloadSection(section)
        }
        
        self.displayMovies.displayMovies(forSection: .nowPlaying, withPage: currentPage) {[unowned self] (total,movies,section) in
            self.nowPlayingMovies = movies
            self.reloadSection(section)
        }
        
        self.displayMovies.displayMovies(forSection: .popular, withPage: currentPage) {[unowned self] (total,movies,section) in
            self.popularMovies = movies
            self.reloadSection(section)
        }
    }
    
    func numberofSections()->Int{
        return MovieSections.totalOrUnknown.rawValue
    }
    
    func numberOfItemsInSection(section:Int)->Int{
        let movieSection = MovieSections(rawValue: section)!
        
        var listForSection:[Movie]? = nil
        switch movieSection {
        case .topRated:
            listForSection = self.topRatedMovies
        case .upcoming:
            listForSection = self.upcomingMovies
        case .nowPlaying:
            listForSection = self.nowPlayingMovies
        case .popular:
            listForSection = self.popularMovies
        default:
            return 0
        }
        
        if let list = listForSection{
            if list.count > maximumRowsInSectionOnHomePage{
                return maximumRowsInSectionOnHomePage
            }
            else{
                return list.count
            }
        }
        
        return 0
    }
    
    func posterImageForMoviewAtIndexPath(indexPath:IndexPath)->String?{
        switch MovieSections(rawValue: indexPath.section)! {
        case .topRated:
            if let list = self.topRatedMovies{
                return list[indexPath.row].posterPathURL()
            }
        case .upcoming:
            if let list = self.upcomingMovies{
                return list[indexPath.row].posterPathURL()
            }
        case .nowPlaying:
            if let list = self.nowPlayingMovies{
                return list[indexPath.row].posterPathURL()
            }
        case .popular:
            if let list = self.popularMovies{
                return list[indexPath.row].posterPathURL()
            }
        default:
            break
        }
        return nil
    }
    
    func section(withTitle title:String)->MovieSections{
        switch title {
        case "Top Rated":
            return .topRated
        case "Upcoming":
            return .upcoming
        case "Now Playing":
            return .nowPlaying
        case "Popular":
            return .popular
        default:
            return .totalOrUnknown
        }
    }
    
    func movieListBelongsToSection(withTitle title:String)->[Movie]{
        switch title {
        case "Top Rated":
            return self.topRatedMovies!
        case "Upcoming":
            return self.upcomingMovies!
        case "Now Playing":
            return self.nowPlayingMovies!
        case "Popular":
            return self.popularMovies!
        default:
            return []
        }
    }
    
    func movieIdForMovie(at indexPath:IndexPath)->Int?{
        switch MovieSections(rawValue: indexPath.section)! {
        case .topRated:
            return self.topRatedMovies?[indexPath.row].id
        case .upcoming:
            return self.upcomingMovies?[indexPath.row].id
        case .nowPlaying:
            return self.nowPlayingMovies?[indexPath.row].id
        case .popular:
            return self.popularMovies?[indexPath.row].id
        default:
            break
        }
        return nil
    }
    
    func titleForSection(indexPath:IndexPath)->String?{
        switch MovieSections(rawValue: indexPath.section)! {
        case .topRated:
                return "Top Rated"
        case .upcoming:
                return "Upcoming"
        case .nowPlaying:
                return "Now Playing"
        case .popular:
                return "Popular"
        default:
            break
        }
        return nil
    }
}
