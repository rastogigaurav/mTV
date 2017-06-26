//
//  Language.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

class Language: NSObject {
    var iso_639_1:String
    var name:String
    
    required init(iso:String, lName:String) {
        self.iso_639_1 = iso
        self.name = lName
    }
}
