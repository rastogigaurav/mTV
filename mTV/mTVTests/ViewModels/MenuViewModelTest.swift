//
//  MenuViewModelTest.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/27/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import XCTest
@testable import mTV

class MenuViewModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDidTappedCellForSection(){
        let expectedResult:XCTestExpectation = expectation(description: "Expected that the Top Rated section has been selected")
        let viewModel:MenuViewModel = MenuViewModel()
        let indexPath = IndexPath(row: 0, section: 0)
        viewModel.didSelect(rowAt: indexPath) { (section) in
            XCTAssertEqual(section, MovieSections.topRated)
            expectedResult.fulfill()
        }
        
        self.waitForExpectations(timeout: 1.0) { (error) in
            if let _ = error{
                XCTFail("Failed to select Top Section Section")
            }
        }
    }
}
