//
//  MovieDetailsRepositoryTest.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import XCTest
@testable import mTV

class MovieDetailsRepositoryTest: XCTestCase {
    
    var repository:MovieDetailsRepository?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.repository = MovieDetailsRepository()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetMovieDetails(){
        let expectedResult:XCTestExpectation = expectation(description: "Expected to get the details of movie from TMDB")
        let movieId = 0
        self.repository?.getDetails(forMovieWith: movieId, completionHandler: { (movie, error) in
            expectedResult.fulfill()
        })

        self.waitForExpectations(timeout: 2.0) { (error) in
            if let _ = error{
                XCTFail("Failed to fetch details from TMDB")
            }
        }
    }
}
