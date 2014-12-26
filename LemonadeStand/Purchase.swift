//
//  Purchase.swift
//  LemonadeStand
//
//  Created by Yosemite on 12/25/14.
//  Copyright (c) 2014 Yosemite. All rights reserved.
//

import Foundation
import UIKit

struct Purchase {
    var lemons = 0
    var iceCubes = 0
    
    init(initLemons:Int, initIceCubes:Int) {
        lemons = initLemons
        iceCubes = initIceCubes
    }
}