//
//  TravelEntity.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/27/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

protocol TravelEntity {
    
    func getCurrentLocation() -> (Int, Int)
    
    func setLocation(x: Int, y: Int)
    
    func getCurrentSolarSystem() -> SolarSystem
    
    func setCurrentSolarSystem(currSolarSystem : SolarSystem)
    
    func setCurrentPlanet(currPlanet: Planet) 
    
    func getShip() -> Ship 
}
