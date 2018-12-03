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
    var image: UIImage?
    var date:Date?
    var description:String?
    
    init(image:UIImage,date:Date,description:String){
        self.image       = image
        self.date        = date
        self.description = description
    }
}

