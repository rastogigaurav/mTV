//
//  MovieListViewController.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SWRevealViewController

class MovieListViewController: UIViewController,UICollectionViewDataSource,UICollectionViewPaginationDelegate,UIScrollViewDelegate,SWRevealViewControllerDelegate {
    var section:MovieSections?
    var viewModel:MovieListViewModel?
    var totalItemCount:Int = Int(INT_MAX)
    
    @IBOutlet weak var movieListCollectionView: UICollectionView_Pagination!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customSetup()
        setupViewModel()
        
        if let title = self.viewModel?.titel(){
            self.title = title
        }
        
        self.viewModel?.fetchMovies(withPage: 1, reload: { (total) in
            self.movieListCollectionView.totalItemCount = total
            self.movieListCollectionView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetails"{
            let movieDetailsViewController = segue.destination as! MovieDetailsViewController
            let indexPath = self.movieListCollectionView.indexPathsForSelectedItems?[0]
            movieDetailsViewController.movieId = (viewModel?.movieId(forMovieAt:indexPath!))!
        }
    }
    
    func addMenuRightButton(){
        let menuImage = UIImage(named: "menuIcon")
        let menuButton:UIBarButtonItem = UIBarButtonItem(image: menuImage, style:.plain, target: revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        
        if revealViewController() != nil{
            revealViewController().rearViewRevealWidth = menuRevealWidth
            revealViewController().delegate = self
        }
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    //MARK: IBActions
    @IBAction func onTapping(back sender:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTapping(filter sender:UIBarButtonItem){
        ActionSheetMultipleStringPicker.show(withTitle: "Select START & END date", rows: [
            years_1950_2017,
            years_1950_2017
            ], initialSelection: [self.viewModel?.startDateIndex as Any,self.viewModel?.endDateIndex as Any],
               doneBlock: {[unowned self] (picker, values, indexes) in
                let startDateIndex = values?[0] as! Int
                let endDateIndex = values?[1] as! Int
                self.viewModel?.filter(basedOn:startDateIndex , endIndex: endDateIndex,
                                      reload:{[unowned self] _ in
                                        self.movieListCollectionView.reloadData()
                })
                
                return
        },
               cancel: { ActionMultipleStringCancelBlock in
                return
        },
               origin: sender
        )
    }
    
    //MARK: UICollectionViewDataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel!.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MovieListCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCustomCell.reuseIdentifier, for: indexPath) as! MovieListCustomCell
        configureCell(cell: cell, forRowAt: indexPath)
        return cell
    }
    
    func configureCell(cell:MovieListCustomCell, forRowAt indexPath:IndexPath){
        if let titleAndReleaseYear = self.viewModel?.titleAndReleaseYearForMovie(at: indexPath){
            cell.movieTitleAndReleaseYearLabel.text = titleAndReleaseYear
        }
        else{
            cell.movieTitleAndReleaseYearLabel.text = nil
        }
        
        if let posterImage = viewModel?.posterImageUrlForMovie(at: indexPath){
            cell.posterImageView.sd_setImage(with: URL(string: posterImage), placeholderImage: UIImage(named: "movie-poster-default"))
        }
        else{
            cell.posterImageView.image = nil
        }
    }
    
    //MARK: UIScrollView Delegates
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.movieListCollectionView.willBeginDecelerating()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.movieListCollectionView.endDecelerating()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.movieListCollectionView.willBeginDragging()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.movieListCollectionView.endDragging(willDecelerate: decelerate)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        self.movieListCollectionView.didScroll()
    }
    
    //MARK:- pagination delegate Methods
    func requestItemForPages(pageSet:NSSet){
        let pageList = pageSet.allObjects
        if let page = pageList.first as? NSNumber{
            if !self.hasItemInPage(pageNo: page.intValue){
                self.viewModel?.fetchMovies(withPage: Int(page), reload: { total in
                    self.movieListCollectionView.totalItemCount = total
                    self.movieListCollectionView.reloadData()
                })
            }
        }
    }
    
    func hasItemInPage(pageNo:Int) -> Bool{
        return (((pageNo * pageSize) <= self.viewModel!.movies.count)||(self.viewModel!.movies.count%pageSize != 0))
    }
    
    //MARK: Private Methods
    private func customSetup(){
        self.movieListCollectionView.paginationEnabled = true
        self.movieListCollectionView.paginationDelegate = self
        self.movieListCollectionView.pageSize = pageSize
        self.movieListCollectionView.totalItemCount = totalItemCount
    }
    
    private func setupViewModel(){
        let repository:MoviesRepository = MoviesRepository()
        let displayMovies:DisplayMovies = DisplayMovies(with: repository)
        self.viewModel = MovieListViewModel(with: displayMovies, selectedSection: self.section!)
    }
}
