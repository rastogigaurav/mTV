//
//  MovieCustomCell.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/22/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

class MovieCustomCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    
    class var reuseIdentifier: String{
        return "MovieCustomCell"
    }
}
