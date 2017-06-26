//
//  MovieListViewModelTest.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import XCTest
@testable import mTV

class MovieListViewModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //self.viewModel = MovieListViewModel(with:displayMovieList)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFilterList(){
        let expectedResult:XCTestExpectation = expectation(description: "Expected to provide a filtered list based the on range of release dates provided")
        
        let displayMovies:DisplayMoviesMock = DisplayMoviesMock()
        let viewModel:MovieListViewModel = MovieListViewModel(with: displayMovies, selectedSection: .totalOrUnknown)

        viewModel.filter(basedOn: 0, endIndex: 1) { _ in
            XCTAssertTrue(displayMovies.filterMovieListIsCalled)
            expectedResult.fulfill()
        }

        self.waitForExpectations(timeout: 1.0) { (error) in
            if let _ =  error{
                XCTFail("Failed to filter list based on release dates")
            }
        }
    }
    
    func testFetchMovies(){
        let expectedResult:XCTestExpectation = expectation(description: "Expected to fetch movies with repect to specific MovieSection")
        
        let displayMovies:DisplayMoviesMock = DisplayMoviesMock()
        let viewModel:MovieListViewModel = MovieListViewModel(with: displayMovies, selectedSection: .totalOrUnknown)
        
        viewModel.fetchMovies(withPage: 0) { total in
            XCTAssertTrue(displayMovies.displayMoviesIsCalled)
            expectedResult.fulfill()
        }

        self.waitForExpectations(timeout: 1.0) { (error) in
            if let _ =  error{
                XCTFail("Failed to fetch movies from TMDB")
            }
        }
    }
}
