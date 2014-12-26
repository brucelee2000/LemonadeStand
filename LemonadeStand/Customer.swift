//
//  Customer.swift
//  LemonadeStand
//
//  Created by Yosemite on 12/25/14.
//  Copyright (c) 2014 Yosemite. All rights reserved.
//

import Foundation
import UIKit

struct Customer {
    var tastePreference = 0.0
    var tasteType = ""
    
    init(customerTaste:Double) {
        tastePreference = customerTaste
    }
}
