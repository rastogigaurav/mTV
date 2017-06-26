//
//  DisplayMovieDetailsTest.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import XCTest
@testable import mTV

class DisplayMovieDetailsTest: XCTestCase {
    
    let repository:MovieDetailsRepositoryMock = MovieDetailsRepositoryMock()
    var displayMovieDetails:DisplayMovieDetails?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.displayMovieDetails = DisplayMovieDetails(with:repository)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchMovieDetail(){
        let expectedResult:XCTestExpectation = expectation(description: "Expected to fetch movie details using MovieDetailsRepository")
        let movieId = 0
        self.displayMovieDetails?.fetchDetails(forMovieWith:movieId, completionHandler:{[unowned self](movie) in
            XCTAssertTrue(self.repository.getMovieDetailsIsCalled)
            expectedResult.fulfill()
        })
        self.waitForExpectations(timeout: 1.0) { (error) in
            if let _ = error {
                XCTFail("Failed to get details of movie using MovieDetailsRepository")
            }
        }
    }
    
}
