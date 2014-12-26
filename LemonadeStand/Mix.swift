//
//  Mix.swift
//  LemonadeStand
//
//  Created by Yosemite on 12/25/14.
//  Copyright (c) 2014 Yosemite. All rights reserved.
//

import Foundation
import UIKit

struct Mix {
    var lemons = 0
    var iceCubes = 0
    var lemonadeRatio:Double?
    var lemonadeType:String = ""
    
    init(alemons:Int, aIceCubes:Int) {
        lemons = alemons
        iceCubes = aIceCubes
    }
}