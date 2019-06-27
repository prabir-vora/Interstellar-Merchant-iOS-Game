//
//  Inventory.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/1/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import Foundation

public class Inventory: NSObject, NSCoding {
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(size, forKey: "Size")
        aCoder.encode(inventory, forKey: "Inventory")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.size = aDecoder.decodeObject(forKey: "Size") as! Int
        self.inventory = aDecoder.decodeObject(forKey: "Inventory") as! [Item: Int]
        
    }
    
    private var size: Int = 0
    private var inventory: [Item: Int] = [Item: Int]()
    
    override init() {
        
    }
    
    func contains(subset: [Item: Int]) -> Bool {
        var valid: Bool = true
        for (item, _) in subset {
            if !inventory.keys.contains(item) {
                return false
            }
            
            for (item, quantity) in subset {
                if inventory[item]! < quantity {
                    valid = false
                }
            }
            
        }
        return valid
    }
    
    func assign(subset: [Item: Int]) {
        for (item, quantity) in subset {
            if inventory.keys.contains(item) {
                inventory[item] = inventory[item]! + quantity
            } else {
                inventory[item] = quantity
            }
            size += quantity
        }
    }
    
    func remove(subset: [Item: Int]) {
        for (item, quantity) in subset {
            if inventory.keys.contains(item) {
                inventory[item] = inventory[item]! - quantity
                
            }
            
            size -= quantity
        }
    }
    
    func getUsedSpace() -> Int {
        return size
    }
    
    func getInventory() -> [Item: Int] {
        return inventory
    }
    
    func clear() {
        size = 0
        inventory = [Item: Int]()
        
    }
    
    
}
