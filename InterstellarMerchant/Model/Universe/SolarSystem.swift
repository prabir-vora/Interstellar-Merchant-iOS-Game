//
//  SolarSystem.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/28/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import UIKit

public class SolarSystem: NSObject, Location {
    
    enum Keys: String {
        case name = "Name"
        case xCoord = "xCoord"
        case yCoord = "yCoord"
        case planets = "Planets"
        case planetLocations = "PlanetLocations"
        case numberOfPlanets = "NumberOfPlanets"

    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Keys.name.rawValue)
        aCoder.encode(xCoord, forKey: Keys.xCoord.rawValue)
        aCoder.encode(yCoord, forKey: Keys.yCoord.rawValue)
        aCoder.encode(planets, forKey: Keys.planets.rawValue)
        aCoder.encode(planetLocations, forKey: Keys.planetLocations.rawValue)
        aCoder.encode(numberOfPlanets, forKey: Keys.numberOfPlanets.rawValue)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: Keys.name.rawValue) as! String
        self.xCoord = aDecoder.decodeInteger(forKey: Keys.xCoord.rawValue)
        self.yCoord = aDecoder.decodeInteger(forKey: Keys.yCoord.rawValue)
        self.planets = aDecoder.decodeObject(forKey: Keys.planets.rawValue) as! [Planet]
        self.planetLocations = aDecoder.decodeObject(forKey: Keys.planetLocations.rawValue) as! [(x: Int, y: Int)]
        self.numberOfPlanets = aDecoder.decodeInteger(forKey: Keys.numberOfPlanets.rawValue)
        super.init()
    }
    
    
    public static func == (lhs: SolarSystem, rhs: SolarSystem) -> Bool {
        return lhs.name == rhs.name
    }

    private var name: String
    private var planets: [Planet] = []
    private var numberOfPlanets: Int
    private var planetLocations = [(x: Int, y: Int)]()
    private var xCoord: Int
    private var yCoord: Int
   // private lazy var description = "\(name!), Location: (\(xCoord!), \(yCoord!))"
    
    //MARK: Constructor
    init(numberOfPlanets: Int, name: String, xCoord: Int, yCoord: Int) {
        self.name = name
        self.numberOfPlanets = numberOfPlanets
        self.xCoord = xCoord
        self.yCoord = yCoord
        super.init()
        
        var planetLocations = [(x: Int, y: Int)]()
        
        for _ in 1...numberOfPlanets {
            
            let name: String
            let randomNameIndex = Int.random(in: 0..<planetNames.count)
            name = planetNames[randomNameIndex]
            planetNames.remove(at: randomNameIndex)
            
            let techLevel = Tech.getRandomTech()
            let resource =  Resource.getRandomResource()
            
            var xRandom: Int = 0
            var yRandom: Int = 0
            repeat {
                xRandom = Int.random(in: 0...500)
                yRandom = Int.random(in: 0...500)
            } while !containsLocation(xCoord: xRandom, yCoord: yRandom)
            
            let randomImageIndex = Int.random(in: 0..<planetImages.count)
            let planetImage: UIImage = planetImages[randomImageIndex]
            planetImages.remove(at: randomImageIndex)
            
            let currPlanet = Planet(name: name, techLevel: techLevel, resource: resource, solarSystem: self, planetImage: planetImage, xCoordinate: xRandom, yCoordinate: yRandom)
            
            let planetEconomy: Economy = PlanetEconomy(planet: currPlanet)
            let currMarket: Market = Market(economy: planetEconomy)
            
            currPlanet.setPlanetMarket(market: currMarket)
            
            planetLocations.append((xRandom, yRandom))
            planets.append(currPlanet)
        }
    }
    
    func containsLocation(xCoord: Int, yCoord: Int) -> Bool {
        if planetLocations.count == 0 {
            return true
        }
        for (x, y) in planetLocations {
            if xCoord == x && yCoord == y {
                return false
            }
        }
        return true
    }
    
    //MARK: Coordinate methods
    
    public func setX(x: Int) {
        self.xCoord = x
    }
    
    public func setY(y: Int)  {
        self.yCoord = y
    }
    
    public func getX() -> Int {
        return xCoord
    }
    
    public func getY() -> Int {
        return yCoord
    }
    
    //MARK: Getters and Setters
    
    public func setName(name: String) {
        self.name = name;
    }
    
    public func getName() -> String {
        return name ;
    }

    public func getPlanets() -> [Planet] {
        return planets
    }
    
    
    //MARK: Additional Methods
    public func toString() -> String {
        return description
    }
    
    //MARK: Additional Data Storage
    
    private var planetNames = [
        "Acamar",
        "Adahn",        // The alternate personality for The Nameless One in "Planescape: Torment"
        "Aldea",
        "Andevian",
        "Antedi",
        "Balosnee",
        "Baratas",
        "Brax",            // One of the heroes in Master of Magic
        "Bretel",        // This is a Dutch device for keeping your pants up.
        "Calondia",
        "Capelle",        // The city I lived in while programming this game
        "Carzon",
        "Castor",        // A Greek demi-god
        "Cestus",
        "Cheron",
        "Daled",
        "Damast",
        "Davlos",
        "Deneb",
        "Deneva",
        "Devidia",
        "Draylon",
        "Drema",
        "Endor",
        "Esmee",        // One of the witches in Pratchett's Discworld
        "Exo",
        "Ferris",        // Iron
        "Festen",        // A great Scandinavian movie
        "Fourmi",        // An ant, in French
        "Frolix",        // A solar system in one of Philip K. Dick's novels
        "Gemulon",
        "Guinifer",        // One way of writing the name of king Arthur's wife
        "Hades",        // The underworld
        "Hamlet",        // From Shakespeare
        "Helena",        // Of Troy
        "Hulst",        // A Dutch plant
        "Iodine",        // An element
        "Iralius",
        "Janus",        // A seldom encountered Dutch boy's name
        "Japori",
        "Jarada",
        "Jason",        // A Greek hero
        "Kaylon",
        "Khefka",
        "Kira",            // My dog's name
        "Klaatu",        // From a classic SF movie
        "Korma",        // An Indian sauce
        "Kravat",        // Interesting spelling of the French word for "tie"
        "Krios",
        "Laertes",        // A king in a Greek tragedy
        "Largo",
        "Lave",            // The starting system in Elite
        "Ligon",
        "Lowry",        // The name of the "hero" in Terry Gilliam's "Brazil"
        "Magrat",        // The second of the witches in Pratchett's Discworld
        "Malcoria",
        "Melina",
        "Mentar",        // The Psilon home system in Master of Orion
        "Merik",
        "Mintaka",
        "Montor",        // A city in Ultima III and Ultima VII part 2
        "Mordan",
        "Myrthe",        // The name of my daughter
        "Nelvana",
        "Nix",            // An interesting spelling of a word meaning "nothing" in Dutch
        "Nyle",            // An interesting spelling of the great river
        "Odet",
        "Og",            // The last of the witches in Pratchett's Discworld
        "Omega",        // The end of it all
        "Omphalos",        // Greek for navel
        "Orias",
        "Othello",        // From Shakespeare
        "Parade",        // This word means the same in Dutch and in English
        "Penthara",
        "Picard",        // The enigmatic captain from ST:TNG
        "Pollux",        // Brother of Castor
        "Quator",
        "Rakhar",
        "Ran",            // A film by Akira Kurosawa
        "Regulas",
        "Relva",
        "Rhymus",
        "Rochani",
        "Rubicum",        // The river Ceasar crossed to get into Rome
        "Rutia",
        "Sarpeidon",
        "Sefalla",
        "Seltrice",
        "Sigma",
        "Sol",            // That's our own solar system
        "Somari",
        "Styris",
        "Talani",
        "Tamus",
        "Tantalos",        // A king from a Greek tragedy
        "Tanuga",
        "Terosa",
        "Thera",        // A seldom encountered Dutch girl's name
        "Titan",        // The largest moon of Jupiter
        "Torin",        // A hero from Master of Magic
        "Triacus",
        "Turkana",
        "Tyrus",
        "Utopia",        // The ultimate goal
        "Vadera",
        "Vagra",
        "Vandor",
        "Ventax",
        "Xenon",
        "Xerxes",        // A Greek hero
        "Yew",            // A city which is in almost all of the Ultima games
        "Yojimbo",        // A film by Akira Kurosawa
        "Zalkon",
        "Zuul"            // From the first Ghostbusters movie
    ]
    
    private var planetImages: [UIImage] = [#imageLiteral(resourceName: "Planet 2"), #imageLiteral(resourceName: "Planet 7"), #imageLiteral(resourceName: "Planet 1"), #imageLiteral(resourceName: "Planet 5"), #imageLiteral(resourceName: "Planet 4"), #imageLiteral(resourceName: "Planet 6"), #imageLiteral(resourceName: "Planet 10"), #imageLiteral(resourceName: "Planet 3"), #imageLiteral(resourceName: "Planet 9"), #imageLiteral(resourceName: "Planet 8")]
    
}


extension SolarSystem {
   
    func contains(a:[(Int, Int)], v:(Int,Int)) -> Bool {
        let (c1, c2) = v
        for (v1, v2) in a { if v1 == c1 && v2 == c2 { return true } }
        return false
    }
    
}


