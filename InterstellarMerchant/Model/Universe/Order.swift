//
//  Order.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/27/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import Foundation

//Takes in a dictionary of Items: Quantity and processed its total cost, minimum cost level, etc.

public class Order {
    private var totalCost: Int? = nil
    var quantity = 0
    var minSellTech: Tech?  = nil
    var order = [Item:Int]()
    
    init(order: [Item: Int]) {
        for (item, quantity) in order {
            if minSellTech == nil || Tech.compare(tech1: minSellTech!, tech2: item.sellTechLevel) < 0 {
                minSellTech = item.sellTechLevel
            }
            self.quantity = quantity
        }
        self.order = order 
    }
    
    func setPrice(totalCost: Int) {
        self.totalCost = totalCost
    }
    
    func getTotalCost() -> Int {
        return totalCost!
    }
    
    func getQuantity() -> Int {
        return quantity
    }
    
    func getOrder() -> [Item: Int] {
        return order 
    }
    
    func getMinSellTech() -> Tech {
        return minSellTech!
    }
}

public enum OrderStatus: String {
    case NOT_ENOUGH_SPACE, NOT_ENOUGH_CREDITS, NOT_ENOUGH_TECH, SUCCESS, INVALID_QUANITITY
    
}
