//
//  MovieDetailsViewController.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController,UITableViewDataSource {
    let repository:MovieDetailsRepository = MovieDetailsRepository()
    var displayMovieDetails:DisplayMovieDetails?
    var viewModel:MovieDetailsViewModel?
    @IBOutlet weak var movieDetailsTableView:UITableView!
    
    var movieId:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        movieDetailsTableView.rowHeight = UITableViewAutomaticDimension
        movieDetailsTableView.estimatedRowHeight = 140
        
        self.setupViewModel()
        self.viewModel?.fetchDetailAndPopulate(forMovieWith: self.movieId, reload:{[unowned self] _ in
            self.movieDetailsTableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: IBActions
    @IBAction func onTapping(back sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Private Methods
    func setupViewModel(){
        self.displayMovieDetails = DisplayMovieDetails(with: self.repository)
        self.viewModel = MovieDetailsViewModel(with: self.displayMovieDetails!)
    }
    
    //TableView Datasource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.viewModel?.numberOfRowsInSection(section: section))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieDetailCustomCell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCustomCell.reuseIdentifier) as! MovieDetailCustomCell
        self.configure(cell:cell, forRowAt:indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func configure(cell:MovieDetailCustomCell, forRowAt indexPath:IndexPath){
        if let posterImage = self.viewModel?.movie?.posterPathURL(){
            cell.posterImageView.sd_setImage(with: URL(string: posterImage), placeholderImage: UIImage(named: "movie-poster-default"))
        }
        else{
            cell.posterImageView.image = nil
        }
        
        if let movieTitle = self.viewModel?.movie?.title{
            cell.movieTitleLabel.text = movieTitle
        }
        
        if let tagline = self.viewModel?.movie?.tagline{
            cell.taglineLabel.text = tagline
        }
        
        if let releaseYear = self.viewModel?.movie?.releaseYear{
            cell.releaseYearLabel.text = String(releaseYear)
        }
        
        if let language = self.viewModel?.spokenLanguagesString(){
            cell.languageLabel.text = language
        }
        
        if let companiesNames = self.viewModel?.namesOfProductionCompanies(){
            cell.productionCompanyLabel.text = companiesNames
        }
        
        if let movieOverview = self.viewModel?.movie?.overview{
            cell.movieOverviewLabel.text = movieOverview
        }
    }
}
