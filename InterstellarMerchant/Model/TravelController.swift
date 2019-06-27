//
//  TravelController.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/17/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import Foundation

public class TravelController {
    
    static var travelCounter = 0
    
    /**
     * Set's the travel entity's location without penalty
     *
     */
    init() {
        
    }
    
    func setLocationWithoutPenalty(entity: TravelEntity, newLocation: (Int, Int)) {
        entity.setLocation(x: newLocation.0, y: newLocation.1)
    }
    
    func travel(entity: TravelEntity, newLocation: (Int, Int), newSolarSystem: SolarSystem, isTripFree: Bool) -> (Int, Int) {
        let trip: Trip = Trip(startLocation: entity.getCurrentLocation(), startingSolarSystem: entity.getCurrentSolarSystem(), endLocation: newLocation, endingSolarSystem: newSolarSystem)
        var returnLocation: (Int, Int) = (0, 0)
        let entityShip: Ship = entity.getShip()
        
        if isTripFree {
            entity.setLocation(x: newLocation.0, y: newLocation.1)
            entity.setCurrentSolarSystem(currSolarSystem: newSolarSystem)
            returnLocation = newLocation
        } else if (trip.fuelCost! <= entityShip.getFuel()) {
            returnLocation = newLocation
            entity.setLocation(x: newLocation.0, y: newLocation.1)
            entity.setCurrentSolarSystem(currSolarSystem: newSolarSystem)
            entityShip.deductFuel(fuelCost: trip.fuelCost!)
        } else {
            returnLocation = entity.getCurrentLocation()
        }
        return returnLocation
        
    }
    
    func travelCost(entity: TravelEntity, newLocation: (Int, Int), newSolarSystem: SolarSystem, isTripFree: Bool) -> Int {
        let trip: Trip = Trip(startLocation: entity.getCurrentLocation(), startingSolarSystem: entity.getCurrentSolarSystem(), endLocation: newLocation, endingSolarSystem: newSolarSystem)
        return trip.fuelCost!
    }
    
    static func getTravelCounter() -> Int {
        let returnCount = travelCounter
        travelCounter += 1
        return returnCount
    }

}
