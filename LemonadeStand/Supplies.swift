//
//  Supplies.swift
//  LemonadeStand
//
//  Created by Yosemite on 12/25/14.
//  Copyright (c) 2014 Yosemite. All rights reserved.
//

import Foundation
import UIKit

struct Supplies {
    var money = 10
    var lemons = 1
    var iceCubes = 1
    
    init(aMoney:Int, aLemons:Int, aIceCubes:Int) {
        money = aMoney
        lemons = aLemons
        iceCubes = aIceCubes
    }
}
