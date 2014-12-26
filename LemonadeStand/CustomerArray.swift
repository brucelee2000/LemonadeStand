//
//  CustomerArray.swift
//  LemonadeStand
//
//  Created by Yosemite on 12/25/14.
//  Copyright (c) 2014 Yosemite. All rights reserved.
//

import Foundation
import UIKit

class CustomerArray {
    // Create a customer array with randome taste for each people
    class func createArray() -> [Customer] {
        var customers:[Customer] = []
        
        let customerNumber = Int(arc4random_uniform(UInt32(10)))
        for var index = 0; index < customerNumber; ++index {
            let customerPreference = Double(arc4random_uniform(UInt32(10))) / 10.0
            var customer = Customer(customerTaste: customerPreference)
            
            if customerPreference <= 0.4 {
                customer.tasteType = "Acidic Lemonade"
            } else if customerPreference >= 0.6 {
                customer.tasteType = "Diluted Lemonade"
            } else {
                customer.tasteType = "Equal Portioned Lemonade"
            }
            
            customers.append(customer)
        }
        
        return customers
    }
}