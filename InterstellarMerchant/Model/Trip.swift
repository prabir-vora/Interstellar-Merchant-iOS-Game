//
//  Trip.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/17/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import Foundation

class Trip {
    var fuelCost: Int? = nil
    let solarMultiplier = 5
    let planetMutliplier = 1
    
    init(startLocation: (Int, Int), startingSolarSystem: SolarSystem, endLocation: (Int, Int), endingSolarSystem: SolarSystem) {
        fuelCost = determineCost(startLocation: startLocation, startingSolarSystem: startingSolarSystem, endLocation: endLocation, endingSolarSystem: endingSolarSystem)
    }
    
    func determineCost(startLocation: (Int, Int), startingSolarSystem: SolarSystem, endLocation: (Int, Int), endingSolarSystem: SolarSystem) -> Int {
        var xOne: Int
        var yOne: Int
        var xTwo: Int
        var yTwo: Int
        var multiplier: Int
        if (startingSolarSystem == endingSolarSystem) {
            xOne = startLocation.0
            yOne = startLocation.1
            xTwo = endLocation.0
            yTwo = endLocation.1
            multiplier = planetMutliplier
        } else {
            xOne = startingSolarSystem.getX()
            yOne = startingSolarSystem.getY()
            xTwo = endingSolarSystem.getX()
            yTwo = endingSolarSystem.getY()
            multiplier = solarMultiplier
        }
        
        let dist: Int = distance(x: xOne - xTwo, y: yOne - yTwo)
        return (dist * multiplier)
    }
    
    func distance(x: Int, y: Int) -> Int {
        var sum = hypot(Double(x), Double(y))
        if sum < 0 {
            sum = -sum
        }
        sum = sqrt((sum))
    return Int(sum)
    }

}
