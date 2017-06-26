//
//  Production.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

class ProductionCompany: NSObject {
    
    var id:Int
    var name:String
    
    required init(pID:Int, pName:String) {
        self.id = pID
        self.name = pName
    }
}
