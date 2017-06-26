//
//  MenuViewController.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/21/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var viewModel:MenuViewModel?
    
    @IBOutlet weak var menuTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: IBActions
    @IBAction func onTappingHome(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let navigationController:UINavigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.navigationBar.isTranslucent = false
        self.revealViewController().pushFrontViewController(navigationController, animated: true)
    }
    
    //MARK: Private Methods
    func setupViewModel(){
        self.viewModel = MenuViewModel()
    }
    
    func configure(cell:UITableViewCell, forRowAt indexPath:IndexPath){
        cell.textLabel?.text = self.viewModel?.title(forRowAt: indexPath)
    }
    
    //MARK: UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.viewModel?.numberOfRowsInSection(section: section))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        configure(cell: cell, forRowAt: indexPath)
        return cell
    }
    
    //MARK: UITableVIew Datasource Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.didSelect(rowAt: indexPath, pushToMovieList: { (section) in
            let section = MovieSections(rawValue: indexPath.row)!
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let movieListViewController = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
            movieListViewController.section = section
            movieListViewController.addMenuRightButton()
            let navigationController:UINavigationController = UINavigationController(rootViewController: movieListViewController)
            navigationController.navigationBar.isTranslucent = false
            self.revealViewController().pushFrontViewController(navigationController, animated: true)
        })
    }
}
