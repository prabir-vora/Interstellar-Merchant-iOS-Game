//
//  Ship.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/23/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import UIKit

public class Ship {
    private var type: ShipType
    private var cargo: String = ""
    private var fuel: Int
    
    init(type: ShipType) {
        self.type = type
        self.fuel = 1000
    }
    
    public func getType() -> ShipType {
        return type
    }
    
    public func getFuel() -> Int {
        return fuel
    }
    
    public func deductFuel(fuelCost: Int) {
        self.fuel -= fuelCost
    }
    
    func addFuel(fuelAmount: Int) {
        fuel += fuelAmount
    }
    
    func setShipType(type: ShipType) {
        self.type = type
    }
    
}

public enum ShipType {

    case FLEA
    case GNAT
    case FIREFLY
    case BUMBLEBEE
    case HORNET
    case GRASSHOPPER
    case TERMITE
    
    static func toString(shipType: ShipType) -> String {
        switch shipType {
        case .FLEA: return "Flea"
        case .GNAT: return "GNAT"
        case .FIREFLY: return "Firefly"
        case .BUMBLEBEE: return "Bumblebee"
        case .HORNET: return "Hornet"
        case .GRASSHOPPER: return "Grasshopper"
        case .TERMITE: return "Termite"
        }
    }
    
    static func getCapacity(shipType: ShipType) -> Int {
        switch shipType {
        case .GNAT: return 15
        case .FIREFLY: return 20
        case .BUMBLEBEE: return 50
        case .HORNET: return 25
        case .GRASSHOPPER: return 30
        case .FLEA: return 40
        case .TERMITE: return 60
        }
    }
    
    static func getImage(shipType: ShipType) -> UIImage {
        switch shipType {
        case .GNAT: return UIImage(named: "Space Ship 0")!
        case .FIREFLY: return UIImage(named: "Space Ship 1")!
        case .BUMBLEBEE: return UIImage(named: "Space Ship 2")!
        case .HORNET: return UIImage(named: "Space Ship 3")!
        case .GRASSHOPPER: return UIImage(named: "Space Ship 4")!
        case .FLEA: return UIImage(named: "Space Ship 5")!
        case .TERMITE: return UIImage(named: "Space Ship 6")!
        }
    }
    static func getCost() -> [ShipType: Int] {
        return [ShipType.GNAT: 0, ShipType.FIREFLY: 200, ShipType.BUMBLEBEE: 400, ShipType.HORNET: 250, ShipType.GRASSHOPPER: 300, ShipType.FLEA: 450, ShipType.TERMITE: 500]
    }
    
    static var cases: [ShipType] = [.FLEA, .GNAT, .FIREFLY, .BUMBLEBEE, .HORNET, .GRASSHOPPER, .TERMITE]
    
}

//class AppShipType: NSObject, NSCoding {
//    func encode(with aCoder: NSCoder) {
//        <#code#>
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        <#code#>
//    }
//
//    var shipType: ShipType
//
//    init(shipType: ShipType) {
//        self.shipType = shipType
//    }
//}
