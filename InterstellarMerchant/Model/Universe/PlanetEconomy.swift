//
//  PlanetEconomy.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/6/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import Foundation

/*
 Implements the economy model for the planet
 Will take in Planet as a input in constructor
 Makes the decisions of whether a player can buy the items from the planet..
 
 */
class PlanetEconomy: NSObject, NSCoding, Economy {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(planet, forKey: "Planet")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.planet = aDecoder.decodeObject(forKey: "Planet") as! Planet
        super.init()
    }
    
    
    let planet: Planet
    
    init(planet: Planet) {
        self.planet = planet
    }
    
    func canBuyItems(order: Order) -> OrderStatus {
        var output: OrderStatus
        
        if( Tech.compare(tech1: order.getMinSellTech(), tech2: planet.getTechLevel()) > 0) {
            output = OrderStatus.NOT_ENOUGH_TECH
        } else {
            output = OrderStatus.SUCCESS
        }
        return output
    }
    
    func calculatePrice(item: Item) -> Int {
        var price: Int = 0
        price = item.base
        
        price += (Tech.compare(tech1: planet.getTechLevel(), tech2: item.sellTechLevel)) * item.priceIncreasePerTech
        
        let coinFlip: Int = Int.random(in: 0...1)
        var varMultplier: Int = 1
        if coinFlip == 1 {
            varMultplier = -1
        }
        
        var variance: Int = Int.random(in: 0...item.variance)
        variance = ((varMultplier * varMultplier) / 100) * item.base
        
        price += variance

        return price
    }
    
    func filterItems(potentialItems: [Item]) -> [Item] {
        
        var outputList = [Item]()
        for item in potentialItems {
            if Tech.compare(tech1: planet.getTechLevel(), tech2: item.produceTechLevel) > 0 {
                //let randomInt: Int = Int.random(in: 1...100)
               // if (randomInt < 80) {
                    outputList.append(item)
                //}
            }
        }
        return outputList
    }
    
    func calculateQuantity(item: Item) -> Int {
        var factor: Int
        var signFactor: Int
        var minVariance: Int
        var maxVariance: Int
        
        if (item.idealTechLevel == planet.getTechLevel()) { // increase quantity if ideal tech level
            minVariance = 50
            maxVariance = 150
            signFactor = 1
        } else {
            let randomBool = Bool.random()
            if (randomBool) {
                signFactor = -1
            } else {
                signFactor = 1
            }
            minVariance = 10
            maxVariance = 90
        }
        
        factor = Int.random(in: 0..<(maxVariance - minVariance)) + minVariance
        let netVariance: Int = Int(Double(signFactor) * ((Double(factor)/100.0) * Double(item.baseQuantity)))
        return item.baseQuantity + netVariance
    }
    
}

