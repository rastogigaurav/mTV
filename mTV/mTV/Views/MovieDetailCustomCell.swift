//
//  MovieDetailCustomCell.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/26/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

class MovieDetailCustomCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var productionCompanyLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class var reuseIdentifier: String {
        return "MovieDetailCustomCell"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
