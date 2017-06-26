//
//  DisplayMovieListTest.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import XCTest
@testable import mTV

class DisplayMovieListTest: XCTestCase {
    
    var displatMovieList:DisplayMovieList?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        displatMovieList = DisplayMovieList()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFilterMoviesByReleaseDate(){
        let expectedResult:XCTestExpectation = expectation(description: "Expected to filter the movie list based on release dates")
        let jsonDictionary1 = Dictionary(dictionaryLiteral: ("releaseDate","1989-02-01"),("id","1"))
        let movie1:Movie = Movie(json:jsonDictionary1)
        
        let jsonDictionary2 = Dictionary(dictionaryLiteral: ("releaseDate","1989-02-01"),("id","1"))
        let movie2:Movie = Movie(json:jsonDictionary2)
        
        let movieList:[Movie] = [movie1,movie2]

        displatMovieList?.filter(movieList: movieList, startDate: Date(), endDate: Date(), completionHandler: { (filteredList) in
            expectedResult.fulfill()
        })
        
        waitForExpectations(timeout: 2.0) { (error) in
            if let _ = error{
                XCTFail("Failed to filter the movie list based on release dates")
            }
        }
    }
}
