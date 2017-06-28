//
//  GenreTest.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/28/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import XCTest
@testable import mTV

class GenreTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialization(){
        let genre:Genre = Genre(gID: 0, gName: "Genre Name")
        XCTAssertEqual(genre.name, "Genre Name")
    }
}
