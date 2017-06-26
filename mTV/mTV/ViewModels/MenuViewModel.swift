//
//  MenuViewModel.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/27/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

class MenuViewModel: NSObject {
    func didSelect(rowAt indexPath:IndexPath, pushToMovieList:@escaping(_ section:MovieSections)->Void)->Void{
        let section = MovieSections(rawValue: indexPath.row)
        pushToMovieList(section!)
    }
    
    func numberOfRowsInSection(section:Int)->Int{
        return MovieSections.totalOrUnknown.rawValue
    }
    
    func title(forRowAt indexPath:IndexPath)->String{
        let section = MovieSections(rawValue: indexPath.row)!
        switch section {
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        default:
            return "Unknown"
        }
    }
}
