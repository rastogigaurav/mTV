//
//  MovieDetailsViewModelTest.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import XCTest
@testable import mTV

class MovieDetailsViewModelTest: XCTestCase {
    
    let displayMovieDetails:DisplayMovieDetailsMock = DisplayMovieDetailsMock()
    var viewModel:MovieDetailsViewModel?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.viewModel = MovieDetailsViewModel(with:displayMovieDetails)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchDetailsAndPopulate(){
        let expectedResult:XCTestExpectation = expectation(description: "Expected to fetch details of movie from TMDB and populate the data onto screen")
        let movieId = 0
        self.viewModel?.fetchDetailAndPopulate(forMovieWith:movieId, reload:{[unowned self](movie) in
            XCTAssertTrue(self.displayMovieDetails.fetchDetailsIsCalled)
            expectedResult.fulfill()
        })
        self.waitForExpectations(timeout: 1.0) { (error) in
            if let _ = error{
            XCTFail("Failed to retrieve movie details from TMDB and populate data")}
        }
    }    
}
