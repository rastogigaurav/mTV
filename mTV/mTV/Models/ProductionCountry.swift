//
//  ProductionCountry.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

class ProductionCountry: NSObject {
    var iso_3166_1:String
    var name:String
    
    required init(iso:String, pcName:String) {
        self.iso_3166_1 = iso
        self.name = pcName
    }
}
