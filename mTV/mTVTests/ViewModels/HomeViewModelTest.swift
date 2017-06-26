//
//  HomeViewModelTest.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import XCTest
@testable import mTV

class HomeViewModelTest: XCTestCase {
    let displayMovies:DisplayMoviesMock = DisplayMoviesMock()
    var viewModel:HomeViewModel?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.viewModel = HomeViewModel(with: displayMovies)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testFetchMovies(){
//        let expectedResult:XCTestExpectation = expectation(description: "Expected to fetch various maovies from Server and Populate them")
//        viewModel?.fetchMovies()
//        viewModel?.reloadSection = {(section) in
//            XCTAssertTrue(self.displayMovies.displayMoviesIsCalled)
//        }
//        
//        self.waitForExpectations(timeout: 10.0) { (error) in
//            if let _ = error{
//                XCTFail("Failed to fetch movies from TMDB and display them")
//            }
//        }
//        expectedResult.fulfill()
//    }
    
    func testTitleForSection(){
        let indexPath = IndexPath(row: 0, section: MovieSections.topRated.rawValue)
        let title = viewModel?.titleForSection(indexPath:indexPath)
        XCTAssertEqual(title, "Top Rated")
    }
}
