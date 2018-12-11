//
//  Catch.swift
//  WhatBugIsThis
//
//  Created by user144818 on 12/3/18.
//  Copyright © 2018 user144818. All rights reserved.
//

import Foundation
import UIKit

struct Catch{
    
    var picURLStr:   String?
    var timestamp:   String?
    var description: String?
    
    init(picURLStr:String?,timestamp:String,description:String){
        self.picURLStr      = picURLStr
        self.timestamp      = timestamp
        self.description    = description
    }
}

