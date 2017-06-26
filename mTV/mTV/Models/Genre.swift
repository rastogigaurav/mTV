//
//  Genre.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/25/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import UIKit

class Genre: NSObject {
    var id:Int
    var name:String
    
    required init(gID:Int, gName:String) {
        self.id = gID
        self.name = gName
    }
}
