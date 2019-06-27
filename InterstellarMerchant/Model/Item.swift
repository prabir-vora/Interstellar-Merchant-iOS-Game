//
//  Item.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/27/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import Foundation

class Item: Hashable, Equatable {
    
//    enum Keys: String {
//        case name = "Name"
//        case produceTechLevel = "ProduceTechLevel"
//        case sellTechLevel = "SellTechLevel"
//        case idealTechLevel = "IdealTechLevel"
//        case base = "Base"
//        case baseQuantity = "BaseQuantity"
//        case priceInc = "PriceInc"
//        case variance = "Variance"
//        case decreaseResource = "DecreaseResource"
//        case minTraderPrice = "MinTraderPrice"
//        case maxTraderPrice = "MaxTraderPrice"
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: Keys.name.rawValue)
//        aCoder.encode(produceTechLevel, forKey: Keys.produceTechLevel.rawValue)
//        aCoder.encode(sellTechLevel, forKey: Keys.sellTechLevel.rawValue)
//        aCoder.encode(idealTechLevel, forKey: Keys.idealTechLevel.rawValue)
//        aCoder.encode(base, forKey: Keys.base.rawValue)
//        aCoder.encode(baseQuantity, forKey: Keys.baseQuantity.rawValue)
//        aCoder.encode(priceIncreasePerTech, forKey: Keys.priceInc.rawValue)
//        aCoder.encode(variance, forKey: Keys.variance.rawValue)
//        aCoder.encode(decreaseResource, forKey: Keys.decreaseResource.rawValue)
//        aCoder.encode(minTraderPrice, forKey: Keys.minTraderPrice.rawValue)
//        aCoder.encode(maxTraderPrice, forKey: Keys.maxTraderPrice.rawValue)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        self.name = aDecoder.decodeObject(forKey: Keys.name.rawValue) as! String
//        self.produceTechLevel = aDecoder.decodeObject(forKey: Keys.produceTechLevel.rawValue) as! Tech
//        self.sellTechLevel = aDecoder.decodeObject(forKey: Keys.sellTechLevel.rawValue) as! Tech
//        self.idealTechLevel = aDecoder.decodeObject(forKey: Keys.idealTechLevel.rawValue) as! Tech
//        self.variance = aDecoder.decodeObject(forKey: Keys.variance.rawValue) as! Int
//        self.base = aDecoder.decodeObject(forKey: Keys.base.rawValue) as! Int
//        self.baseQuantity = aDecoder.decodeObject(forKey: Keys.baseQuantity.rawValue) as! Int
//        self.priceIncreasePerTech = aDecoder.decodeObject(forKey: Keys.priceInc.rawValue) as! Int
//        self.decreaseResource = aDecoder.decodeObject(forKey: Keys.decreaseResource.rawValue) as! Resource
//        self.minTraderPrice = aDecoder.decodeObject(forKey: Keys.minTraderPrice.rawValue) as! Int
//        self.maxTraderPrice = aDecoder.decodeObject(forKey: Keys.maxTraderPrice.rawValue) as! Int
//        super.init()
//
//    }

    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    
    var name: String
    var produceTechLevel: Tech
    var sellTechLevel: Tech
    var idealTechLevel: Tech
    var base: Int
    var baseQuantity: Int
    var priceIncreasePerTech: Int
    var variance: Int
   // var increaseEvent: PlanetEvent
    var decreaseResource: Resource
    var minTraderPrice: Int
    var maxTraderPrice: Int

    init(name: String, produceTechLevel: Tech, sellTechLevel: Tech, idealTechLevel: Tech, base: Int, baseQuantity: Int, priceIncreasePerTech: Int, variance: Int, decreaseResource: Resource, minTraderPrice: Int, maxTraderPrice: Int) {
        self.name = name
        self.produceTechLevel = produceTechLevel
        self.sellTechLevel = sellTechLevel
        self.idealTechLevel = idealTechLevel
        self.base = base
        self.baseQuantity = baseQuantity
        self.priceIncreasePerTech = priceIncreasePerTech
        self.variance = variance
        self.decreaseResource = decreaseResource
        self.minTraderPrice = minTraderPrice
        self.maxTraderPrice = maxTraderPrice
    }

    // var increaseEvent: PlanetEvent
 
        
}

public enum Items {
    case WATER
    case FURS
    case FOOD
    case ORE
    case GAMES
    
    var instance: Item {
        switch self {
        case .WATER: return Item(name: "WATER", produceTechLevel: Tech.AGRICULTURE, sellTechLevel: Tech.AGRICULTURE, idealTechLevel: Tech.RENAISSANCE, base: 30, baseQuantity: 10, priceIncreasePerTech: 3, variance: 4, decreaseResource: Resource.LOTSOFWATER, minTraderPrice: 30, maxTraderPrice: 50)
        case .FURS: return Item(name: "FURS", produceTechLevel: Tech.AGRICULTURE, sellTechLevel: Tech.AGRICULTURE, idealTechLevel: Tech.AGRICULTURE, base: 250, baseQuantity: 10, priceIncreasePerTech: 10, variance: 10, decreaseResource: Resource.RICHFAUNA, minTraderPrice: 230, maxTraderPrice: 80)
        case .FOOD: return Item(name: "FOOD", produceTechLevel: Tech.MEDIEVAL, sellTechLevel: Tech.AGRICULTURE, idealTechLevel: Tech.MEDIEVAL, base: 100, baseQuantity: 10, priceIncreasePerTech: 5, variance: 5, decreaseResource: Resource.RICHSOIL, minTraderPrice: 90, maxTraderPrice: 160)
        case .ORE: return Item(name: "ORE", produceTechLevel: Tech.RENAISSANCE, sellTechLevel: Tech.RENAISSANCE, idealTechLevel: Tech.EARLY_INDUSTRIAL, base: 350, baseQuantity: 10, priceIncreasePerTech: 20, variance: 10, decreaseResource: Resource.MINERALRICH, minTraderPrice: 350, maxTraderPrice: 420)
        case .GAMES: return Item(name: "GAMES", produceTechLevel: Tech.EARLY_INDUSTRIAL, sellTechLevel: Tech.MEDIEVAL, idealTechLevel: Tech.HI_TECH, base: 250, baseQuantity: 10, priceIncreasePerTech: -10, variance: 5, decreaseResource: Resource.ARTISTIC, minTraderPrice: 160, maxTraderPrice: 270)
        }
    }
    
    static func getAll() -> [Item] {
        let all: [Item] = [Items.WATER.instance, Items.FURS.instance, Items.FOOD.instance, Items.ORE.instance, Items.GAMES.instance]
        
        return all
    }
}

