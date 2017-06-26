//
//  HomeViewController.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/20/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit
import SDWebImage
import SWRevealViewController

class HomeViewController: UIViewController,UICollectionViewDataSource,SWRevealViewControllerDelegate {
    var viewModel:HomeViewModel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var movieCollectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customSetup()
        setupViewModel()
        viewModel.fetchMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetails"{
            let movieDetailsViewController = segue.destination as! MovieDetailsViewController
            let indexPath = self.movieCollectionView.indexPathsForSelectedItems?[0]
            if let movieId = self.viewModel.movieIdForMovie(at: indexPath!){
                movieDetailsViewController.movieId = movieId
            }
        }
    }
    
    //MARK: IBAction Methods
    @IBAction func onTappingMore(_ sender:UIButton)->Void{
        let header = sender.superview as! UICollectionReusableView
        let titleForSection = (header.viewWithTag(1) as! UILabel).text!
        let section = self.viewModel.section(withTitle: titleForSection)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let movieListViewController = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        movieListViewController.section = section
        self.navigationController?.pushViewController(movieListViewController, animated: true)
    }
    
    // MARK: CollectionView DataSource Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberofSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MovieCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCustomCell.reuseIdentifier, for: indexPath) as! MovieCustomCell
        configureCell(cell: cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: expectedPosterWidthForCell, height: expectedPosterHeightForCell)
    }
    
    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath)
        let titleLabel = header.viewWithTag(1) as! UILabel
        titleLabel.text = self.viewModel.titleForSection(indexPath: indexPath)
        return header
    }
    
    func configureCell(cell:MovieCustomCell, forRowAtIndexPath indexPath:IndexPath) {
        if let posterImage = viewModel.posterImageForMoviewAtIndexPath(indexPath: indexPath){
            cell.posterImageView.sd_setImage(with: URL(string: posterImage), placeholderImage: UIImage(named: "movie-poster-default"))
        }
        else{
            cell.posterImageView.image = nil
        }
    }
    
    //MARK: Private Methods
    private func customSetup(){
        if revealViewController() != nil{
            revealViewController().rearViewRevealWidth = menuRevealWidth
            revealViewController().delegate = self
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
    }
    
    private func setupViewModel(){
        let moviesRepository:MoviesRepository = MoviesRepository()
        let displayMovies:DisplayMovies = DisplayMovies(with: moviesRepository)
        
        viewModel = HomeViewModel(with: displayMovies)
        viewModel.reloadSection = {(section) in
            if let sectionToBeReloaded = section{
                self.movieCollectionView.reloadSections(IndexSet(integer: sectionToBeReloaded.rawValue))
            }
        }
    }
}
