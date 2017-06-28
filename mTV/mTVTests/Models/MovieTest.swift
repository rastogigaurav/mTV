//
//  MovieTest.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/28/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import XCTest
@testable import mTV

class MovieTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialization(){
        let dictionary:Dictionary = Dictionary(dictionaryLiteral: ("title", "Movie Title"),("overview","Movie Overview"),("release_date","1990-01-01"),("poster_path","path"))
        let movie:Movie = Movie(json:dictionary)
        XCTAssertEqual(movie.title, "Movie Title")
        XCTAssertEqual(movie.releaseYear, 1990)
        XCTAssertEqual(movie.posterPathURL(), "https://image.tmdb.org/t/p/w300_and_h450_bestv2/path")
    }
}
