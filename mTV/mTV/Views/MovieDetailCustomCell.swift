//
//  MovieDetailCustomCell.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/26/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

class MovieDetailCustomCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var productionCompanyLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    class var reuseIdentifier: String {
        return "MovieDetailCustomCell"
    }
}
