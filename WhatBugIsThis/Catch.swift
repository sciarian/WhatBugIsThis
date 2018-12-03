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
    var pic:         UIImage?
    var timestamp:   String?
    var description: String?
    
    init(pic:UIImage?,timestamp:String,description:String){
        self.pic              = pic
        self.timestamp        = timestamp
        self.description      = description
    }
}

