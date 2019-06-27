//
//  Universe.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/28/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import Foundation



class Universe: NSObject, NSCoding {
    
    

    func encode(with aCoder: NSCoder) {
        aCoder.encode(solarSystems, forKey: Keys.SolarSystems.rawValue)
        aCoder.encode(locations, forKey: Keys.locations.rawValue)
        aCoder.encode(numberOfSolarSystems, forKey: Keys.numberOfSolarSystems.rawValue)
    }
    



    required init?(coder aDecoder: NSCoder) {
        self.solarSystems = aDecoder.decodeObject(forKey: Universe.Keys.SolarSystems.rawValue) as! [SolarSystem]
        self.locations = aDecoder.decodeObject(forKey: Universe.Keys.locations.rawValue) as! [(Int, Int)]
        self.numberOfSolarSystems = aDecoder.decodeInteger(forKey: Keys.numberOfSolarSystems.rawValue) 
        super.init()
    }

    static let sharedInstance = Universe(numberOfSolarSystems: 5)
    var solarSystems = [SolarSystem]()
    var numberOfSolarSystems: Int
    var locations: [(Int, Int)] = []
 
    init(numberOfSolarSystems: Int) {
        self.numberOfSolarSystems = numberOfSolarSystems
        super.init()
        for _ in 1...numberOfSolarSystems {
            
            //let solarSystem = SolarSystem(numberOfPlanets: 10)
            
            let randomNameIndex = Int.random(in: 0..<solarSystemNames.count)
            let name: String = solarSystemNames[randomNameIndex]
            solarSystemNames.remove(at: randomNameIndex)
            
            var xRandom: Int = 0
            var yRandom: Int = 0
            repeat {
                xRandom = Int.random(in: 0...500)
                yRandom = Int.random(in: 0...500)
            } while !containsLocation(xCoord: xRandom, yCoord: yRandom)

            let solarSystem = SolarSystem(numberOfPlanets: 10, name: name, xCoord: xRandom, yCoord: yRandom)
            
            locations.append((xRandom, yRandom))
            solarSystems.append(solarSystem)
        }
    }
    
    func containsLocation(xCoord: Int, yCoord: Int) -> Bool {
        if locations.count == 0 {
            return true
        }
        for (x, y) in locations {
            if xCoord == x && yCoord == y {
                return false
            }
        }
        
        return true
    }
    
    func getSolarSystem(name: String) -> SolarSystem? {
        for system in solarSystems {
            if system.getName() == name {
                return system
            }
        }
        return nil
    }
    
    func getSolarSystem(index: Int) -> SolarSystem? {
        if (index >= solarSystems.count) {
            return nil
        }
        return solarSystems[index]
    }
    
    func getAllSolarSystems() -> [SolarSystem] {
        return solarSystems
    }

    
    private var solarSystemNames: [String] = [
        "Campor",
        "Iris",
        "Diana",
        "Leo",
        "Ophelia",
        "Portia",
        "Mira"
    ]
    
    enum Keys: String {
        case SolarSystems = "SolarSystem"
        case locations = "Locations"
        case numberOfSolarSystems = "NumberOfSolarSystems"
    }
}
