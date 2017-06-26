//
//  MovieListCustomCell.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

class MovieListCustomCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleAndReleaseYearLabel: UILabel!
    
    class var reuseIdentifier: String{
        return "MovieListCustomCell"
    }
}
