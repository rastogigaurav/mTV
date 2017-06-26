//
//  MovieDetailsViewModel.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

class MovieDetailsViewModel: NSObject {
    var displayMovieDetails:DisplayMovieDetailsProtocol
    
    var movie:Movie?
    
    init(with displayDetail:DisplayMovieDetailsProtocol) {
        self.displayMovieDetails = displayDetail
    }
    
    func fetchDetailAndPopulate(forMovieWith movieId:Int, reload:@escaping ()->())->Void{
        self.displayMovieDetails.fetchDetails(forMovieWith: movieId) { (movie) in
            self.movie = movie
            reload()
        }
    }
    
    func namesOfProductionCompanies()->String?{
        if let movie = self.movie{
            if movie.productionCompanies.count > 0{
                var companyNames = ""
                for company in (self.movie?.productionCompanies)!{
                    companyNames.append(" | " + company.name)
                }
                
                let index = companyNames.index(companyNames.startIndex, offsetBy: 3)
                return companyNames.substring(from: index)
            }
        }
        return nil
    }
    
    func spokenLanguagesString()->String?{
        if let movie = self.movie{
            if movie.spokenLanguages.count > 0{
                var languages = ""
                for language in (self.movie?.spokenLanguages)!{
                    languages.append(" | " + language.name)
                }
                
                let index = languages.index(languages.startIndex, offsetBy: 3)
                return languages.substring(from: index)
            }
            return (self.movie?.originalLanguage)!
        }
        else{
            return nil
        }
    }
    
    func numberOfRowsInSection(section:Int)->Int{
        return 1
    }
}
