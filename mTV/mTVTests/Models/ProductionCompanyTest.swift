//
//  ProductionCompany.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/28/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import XCTest
@testable import mTV

class ProductionCompanyTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialation(){
        let company:ProductionCompany = ProductionCompany(pID:0, pName:"Production Company Name")
            XCTAssertEqual(company.name, "Production Company Name");
    }
}
