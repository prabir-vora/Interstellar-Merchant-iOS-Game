//
//  Player.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/1/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import Foundation

class Player: TravelEntity {
    func setCurrentPlanet(currPlanet: Planet) {
        self.currPlanet = currPlanet
    }
    
//    enum Keys: String {
//        case currLocation = "currLocation"
//        case currentSolarSystem = "currentSolarSystem"
//        case config = "config"
//        case credits = "credits"
//        case ship = "ship"
//        case name = "name"
//        case skillPoints = "SKillType"
//        case inventory = "Inventory"
//
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(currLocation, forKey: Keys.currLocation.rawValue)
//        aCoder.encode(currentSolarSystem, forKey: Keys.currentSolarSystem.rawValue)
//        aCoder.encode(config, forKey: Keys.config.rawValue)
//        aCoder.encode(credits, forKey: Keys.credits.rawValue)
//        aCoder.encode(ship, forKey: Keys.ship.rawValue)
//        aCoder.encode(name, forKey: Keys.name.rawValue)
//        aCoder.encode(skillPoints, forKey: Keys.skillPoints.rawValue)
//        aCoder.encode(inventory, forKey: Keys.inventory.rawValue)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        self.currLocation = aDecoder.decodeObject(forKey: Keys.currLocation.rawValue) as! (Int, Int)?
//        self.currentSolarSystem = aDecoder.decodeObject(forKey: Keys.currentSolarSystem.rawValue) as! SolarSystem?
//        self.config = aDecoder.decodeObject(forKey: Keys.config.rawValue) as! GameConfig
//        self.credits = aDecoder.decodeObject(forKey: Keys.credits.rawValue) as! Int
//        self.ship = aDecoder.decodeObject(forKey: Keys.ship.rawValue) as! Ship
//        self.name = aDecoder.decodeObject(forKey: Keys.name.rawValue) as! String
//        self.skillPoints = aDecoder.decodeObject(forKey: Keys.skillPoints.rawValue) as! [SkillType: Int]
//        self.inventory = aDecoder.decodeObject(forKey: Keys.inventory.rawValue) as! Inventory
//    }
    
    func getShip() -> Ship {
        return self.ship
    }
    
    func getCurrentSolarSystem() -> SolarSystem {
        return currentSolarSystem!
    }
    
    func setCurrentSolarSystem(currSolarSystem : SolarSystem) {
        self.currentSolarSystem = currSolarSystem
    }

    private let shipsOwned: [ShipType]
    private let MAXIMUM_POINTS = 16
    private let STARTING_CREDITS = 1000
    private let MAX_SPACE = 100000
    private var currLocation: (Int, Int)? = nil
    private var currPlanet: Planet? = nil 
    private var currentSolarSystem: SolarSystem? = nil
    private let config: GameConfig
    private var credits: Int
    private var ship: Ship
    private let name: String
    private var skillPoints: [SkillType: Int]
    private var inventory: Inventory
    
    init(name: String, ship: Ship, config: GameConfig, skillPoints: [SkillType: Int]) {
        shipsOwned = [ShipType.GNAT]
        self.name = name
        self.ship = ship
        self.config = config
        self.skillPoints = skillPoints
        self.credits = self.STARTING_CREDITS
        self.inventory = Inventory()
    }
    
    
    func canBuyItems(order: Order) -> OrderStatus {
        var outputStatus: OrderStatus
        if order.quantity > getAvaiableSpace() {
            outputStatus = .NOT_ENOUGH_SPACE
        } else if order.getTotalCost() > credits {
            outputStatus = .NOT_ENOUGH_CREDITS
        } else {
            outputStatus = .SUCCESS
        }
        return outputStatus
    }
    
    func getShipsOwned() -> [ShipType] {
        return shipsOwned
    }
    
    func setCurrentShip(type: ShipType) {
        ship.setShipType(type: type)
    }
    
    func getName() -> String {
        return name
    }
    
    func getPlayerInventory() -> [Item: Int] {
        return inventory.getInventory()
    }
    
    func getAvaiableSpace() -> Int {
        let usedSpace: Int = inventory.getUsedSpace()
        return MAX_SPACE - usedSpace
    }
    
    func getCredits() -> Int {
        return credits
    }
    
    func setCredits(credits: Int) {
        self.credits = credits
    }
    
    func getSellItems() -> [Item] {
        var sellItems: [Item] = []
        for (key, _) in inventory.getInventory() {
            sellItems.append(key)
        }
        return sellItems
    }
    
    func getInventory() -> Inventory {
        return inventory
    }
    
    func getCurrentLocation() -> (Int, Int) {
        return currLocation ?? (0, 0)
    }
    
    func setLocation(x: Int, y: Int) {
        currLocation = (x, y)
    }
    
}

extension Player {
    public enum SkillType {
        case PILOT, FIGHTER, TRADER, ENGINEER
    }
    

}
