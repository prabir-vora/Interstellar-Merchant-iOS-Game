//
//  Planet.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/25/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import UIKit

/*
 Model for planet
 Stores the planet market, location and other attributes such as name, image, location coordinates, Tech level
 */
public class Planet: NSObject, Location, NSCoding  {
    
    enum Keys: String {
        case name = "Name"
        case techLevel = "TechLevel"
        case market = "Market"
        case resource = "Resource"
        case solarSystem = "SolarSystem"
        case planetImage = "PlanetImage"
        case xCoordinate = "xCoord"
        case yCoordinate = "yCoord"
        
    }
    
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Keys.name.rawValue)
        aCoder.encode(techLevel, forKey: Keys.techLevel.rawValue)
        aCoder.encode(market, forKey: Keys.market.rawValue)
        aCoder.encode(resource, forKey: Keys.resource.rawValue)
        aCoder.encode(solarSystem, forKey: Keys.solarSystem.rawValue)
        aCoder.encode(planetImage, forKey: Keys.planetImage.rawValue)
        aCoder.encode(xCoordinate, forKey: Keys.xCoordinate.rawValue)
        aCoder.encode(yCoordinate, forKey: Keys.yCoordinate.rawValue)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: Keys.name.rawValue) as! String
        self.techLevel = aDecoder.decodeObject(forKey: Keys.techLevel.rawValue) as! Tech
        self.market = aDecoder.decodeObject(forKey: Keys.market.rawValue) as! Market?
        self.resource = aDecoder.decodeObject(forKey: Keys.resource.rawValue) as! Resource
        self.solarSystem = aDecoder.decodeObject(forKey: Keys.solarSystem.rawValue) as! SolarSystem
        self.planetImage = aDecoder.decodeObject(forKey: Keys.planetImage.rawValue) as! UIImage
        self.xCoordinate = aDecoder.decodeInteger(forKey: Keys.xCoordinate.rawValue)
        self.yCoordinate = aDecoder.decodeInteger(forKey: Keys.yCoordinate.rawValue)
        
        super.init()
        
    }
    

    var name: String
    var techLevel: Tech
    var market: Market?
    var resource: Resource
    var solarSystem: SolarSystem
    var planetImage: UIImage
    var xCoordinate: Int
    var yCoordinate: Int
    
    init(name: String, techLevel: Tech, resource: Resource, solarSystem: SolarSystem, planetImage: UIImage, xCoordinate: Int, yCoordinate: Int) {
        self.name = name
        self.techLevel = techLevel
        self.resource = resource
        self.solarSystem = solarSystem
        self.planetImage = planetImage
        self.xCoordinate = xCoordinate
        self.yCoordinate = yCoordinate
    }
    
    
    func getName() -> String {
        return name
    }
    
    //MARK: Coordinate methods
    
    func getX() -> Int {
        return xCoordinate
    }
    
    func getY() -> Int {
        return yCoordinate
    }
    
    func setX(x: Int) {
        xCoordinate = x
    }
    
    func setY(y: Int) {
        yCoordinate = y
    }
    
    func getTechLevel() -> Tech {
        return techLevel
    }
    
    func setTechLevel(techLevel: Tech) {
        self.techLevel = techLevel;
    }
    
    func setPlanetMarket(market: Market) {
        self.market = market
    }
    
    func getPlanetMarket() -> Market {
        return self.market!
    }
    
    func getPlanetImage() -> UIImage {
        return planetImage
    }
    
    func setResource(resource: Resource) {
        self.resource = resource
    }
    
    func getResource() -> Resource {
        return resource
    }
    
    func getSolarSystem() -> SolarSystem {
        return solarSystem
    }
}
