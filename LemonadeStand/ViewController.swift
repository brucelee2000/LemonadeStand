//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Yosemite on 12/25/14.
//  Copyright (c) 2014 Yosemite. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Variables
    var todaySupply = Supplies(aMoney: 10, aLemons: 1, aIceCubes: 1)
    var todayPurchase = Purchase(initLemons: 0, initIceCubes: 0)
    var todayMix = Mix(alemons: 0, aIceCubes: 0)
    var todayCustomersArray:[Customer] = []
    
    
    // Constants
    let kLemonPrice = 2
    let kIceCubePrice = 1
    
    // UI elements to update
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var totalLemons: UILabel!
    @IBOutlet weak var totalIceCubes: UILabel!
    
    @IBOutlet weak var purchasedLemons: UILabel!
    @IBOutlet weak var purchasedIceCubes: UILabel!
    
    @IBOutlet weak var lemonsForMix: UILabel!
    @IBOutlet weak var iceCubesForMix: UILabel!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    @IBAction func purchaseMoreLemonsPressed(sender: UIButton) {
        if todaySupply.money < 2 {
            showAlertWithText(header: "Not Enough Money", message: "You cannot buy lemons any more")
        } else {
            todayPurchase.lemons += 1
            todaySupply.lemons += 1
            todaySupply.money -= kLemonPrice
        }
        
        // Update region
        updateRegions()
    }
  
    @IBAction func purchaseFewerLemonsPressed(sender: UIButton) {
        if todayPurchase.lemons < kLemonPrice {
            showAlertWithText(header: "ERROR", message: "You already have no lemons today")
        } else {
            todayPurchase.lemons -= 1
            todaySupply.lemons -= 1
            todaySupply.money += kLemonPrice
        }
        
        // Update region
        updateRegions()
    }
    
    @IBAction func purchaseMoreIceCubesPressed(sender: UIButton) {
        if todaySupply.money < kIceCubePrice {
            showAlertWithText(header: "Not Enough Money", message: "You cannot buy ice cubes any more")
        } else {
            todayPurchase.iceCubes += 1
            todaySupply.iceCubes += 1
            todaySupply.money -= kIceCubePrice
        }
        
        // Update region
        updateRegions()
    }
    
    @IBAction func purchaseFewerIceCubesPressed(sender: UIButton) {
        if todayPurchase.iceCubes < 1 {
            showAlertWithText(header: "ERROR", message: "You already have no ice cubes today")
        } else {
            todayPurchase.iceCubes -= 1
            todaySupply.iceCubes -= 1
            todaySupply.money += kIceCubePrice
        }
        
        // Update region
        updateRegions()
    }
    
    
    @IBAction func mixMoreLemonsPressed(sender: UIButton) {
        if 0 < todaySupply.lemons {
            todayMix.lemons += 1
            todaySupply.lemons -= 1
        } else {
            showAlertWithText(header: "No more lemons", message: "You need to buy more lemons")
        }
        
        // Update region
        updateRegions()
    }
    
    @IBAction func mixFewerLemonsPressed(sender: UIButton) {
        if todayMix.lemons > 0 {
            todayMix.lemons -= 1
            todaySupply.lemons += 1
        } else {
            showAlertWithText(header: "ERROR", message: "No lemons used in your mix!")
        }
        
        // Update region
        updateRegions()
    }
    
    @IBAction func mixMoreIceCubesPressed(sender: UIButton) {
        if 0 < todaySupply.iceCubes {
            todayMix.iceCubes += 1
            todaySupply.iceCubes -= 1
        } else {
            showAlertWithText(header: "No more ice cubes", message: "You need to buy more ice cubes")
        }
        
        // Update region
        updateRegions()
    }
    
    @IBAction func mixFewerIceCubesPressed(sender: UIButton) {
        if todayMix.iceCubes > 0 {
            todayMix.iceCubes -= 1
            todaySupply.iceCubes += 1
        } else {
            showAlertWithText(header: "ERROR", message: "No ice cubes used in your mix!")
        }
        
        // Update region
        updateRegions()
    }
    
    @IBAction func startDayPressed(sender: UIButton) {
        if todayMix.lemonadeRatio != nil {
            
            todayCustomersArray = CustomerArray.createArray()
            var paidCustomer = 0
            for var index = 0; index < todayCustomersArray.count; ++index {
                var currentCustomer = todayCustomersArray[index]
                
                if currentCustomer.tasteType == todayMix.lemonadeType {
                    //println("Customer \(index) prefers \(currentCustomer.tasteType) and today mix is also \(todayMix.lemonadeType), so he paid")
                    todaySupply.money += 1
                    ++paidCustomer
                } else {
                    //println("Customer \(index) prefers \(currentCustomer.tasteType) but today mix is \(todayMix.lemonadeType), so he bailed")
                }
            }
            
            //println("There are \(todayCustomersArray.count) customers, and \(paidCustomer) of them paid due to the same mix taste")
            resultsLabel.text =  "Today summary:\n👉 Purchased \(todayPurchase.lemons) lemons and \(todayPurchase.iceCubes) ice cubes.\n👉 Today's mix is \(todayMix.lemonadeType)\n👉 \(paidCustomer) of \(todayCustomersArray.count) customers paid"
            
            var moneyInTotal = todaySupply.money
            resetGame()
            todaySupply.money = moneyInTotal
            updateRegions()
            
        } else {
            if todayMix.lemons == 0 && todayMix.iceCubes != 0 {
                showAlertWithText(header: "ERROR", message: "You haven't made any lemonade mix yet! You need lemons :)")
            } else if todayMix.iceCubes == 0 && todayMix.lemons != 0 {
                showAlertWithText(header: "ERROR", message: "You haven't made any lemonade mix yet! You need ice cubes :)")
            } else {
                showAlertWithText(header: "ERROR", message: "You haven't made any lemonade mix yet! You need lemons and ice cubes :)")
            }
            
        }
    }
    
    @IBAction func resetButtonPressed(sender: UIButton) {
        resetGame()
        updateRegions()
        resultsLabel.text = "Rule: you will either make or lose money at the end of the day. If you don't have enough money, you lose the game."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resetGame()
        updateRegions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showAlertWithText(header:String = "Warning", message:String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        // display on the screen
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateRegions() {
        // Update suppply region
        totalMoney.text = "$\(todaySupply.money)"
        totalLemons.text = "\(todaySupply.lemons) lemons"
        totalIceCubes.text = "\(todaySupply.iceCubes) ice cubes"
        
        // Update purchase region
        purchasedLemons.text = "\(todayPurchase.lemons)"
        purchasedIceCubes.text = "\(todayPurchase.iceCubes)"
        
        // Update Mix region
        lemonsForMix.text = "\(todayMix.lemons)"
        iceCubesForMix.text = "\(todayMix.iceCubes)"
        if (todayMix.lemons != 0 && todayMix.iceCubes != 0) {
            todayMix.lemonadeRatio = Double(todayMix.lemons) / Double(todayMix.iceCubes)
            
            if todayMix.lemonadeRatio > 1 {
                todayMix.lemonadeType = "Acidic Lemonade"
            } else if todayMix.lemonadeRatio < 1 {
                todayMix.lemonadeType = "Diluted Lemonade"
            } else {
                todayMix.lemonadeType = "Equal Portioned Lemonade"
            }
            
            println("Current mix ratio is \(todayMix.lemonadeRatio) and type is \(todayMix.lemonadeType)")
        } else {
            todayMix.lemonadeRatio = nil
        }
    }
    
    func resetGame() {
        // Initialize purchase, mix, and supply
        todayPurchase.lemons = 0
        todayPurchase.iceCubes = 0
        todayMix.iceCubes = 0
        todayMix.lemons = 0
        todaySupply.lemons = 1
        todaySupply.iceCubes = 1
        todaySupply.money = 10
    }

}

