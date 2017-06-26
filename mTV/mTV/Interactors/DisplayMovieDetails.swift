//
//  DisplayMovieDetails.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

protocol DisplayMovieDetailsProtocol:NSObjectProtocol {
    func fetchDetails(forMovieWith id:Int, completionHandler:@escaping (_ movie:Movie?)->Void)->Void
}

class DisplayMovieDetailsMock: NSObject,DisplayMovieDetailsProtocol{
    var fetchDetailsIsCalled = false
    
    func fetchDetails(forMovieWith id: Int, completionHandler: @escaping (Movie?) -> Void) {
        self.fetchDetailsIsCalled = true
        completionHandler(nil)
    }
}

class DisplayMovieDetails: NSObject,DisplayMovieDetailsProtocol {
    var repository:MovieDetailsRepositoryProtocol?
    
    init(with mRepository:MovieDetailsRepositoryProtocol) {
        self.repository = mRepository
    }
    
    func fetchDetails(forMovieWith id: Int, completionHandler:@escaping (Movie?) -> Void) {
        self.repository?.getDetails(forMovieWith: id, completionHandler: { (movie, error) in
            if error == nil{
                completionHandler(movie)
            }
        })
    }
}
