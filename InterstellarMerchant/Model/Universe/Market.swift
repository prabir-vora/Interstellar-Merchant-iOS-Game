//
//  Market.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/27/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import Foundation

/*
 Holds all the items in the market for an economy
 Each economy has a market and each market has an inventory and a price log
constructed using Economy as an input
 */
public class Market: NSObject, NSCoding {
    
    enum Keys: String {
        case inventory = "Inventory"
        case economy = "Economy"
        case sellGoods = "SellGOods"
        case priceLog = "PriceLog"
    }
    
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(inventory, forKey: Keys.inventory.rawValue)
        aCoder.encode(economy, forKey: Keys.economy.rawValue)
        aCoder.encode(sellGoods, forKey: Keys.sellGoods.rawValue)
        aCoder.encode(priceLog, forKey: Keys.priceLog.rawValue)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.inventory = aDecoder.decodeObject(forKey: Keys.inventory.rawValue) as! Inventory
        self.economy = aDecoder.decodeObject(forKey: Keys.economy.rawValue) as! Economy
        self.sellGoods = aDecoder.decodeObject(forKey: Keys.sellGoods.rawValue) as! [Item]
        self.priceLog = aDecoder.decodeObject(forKey: Keys.priceLog.rawValue) as! [Item: MarketItemPrice]
        super.init()
    }
    
    private var inventory: Inventory
    private var economy: Economy
    private var sellGoods: [Item]
    private var priceLog: [Item: MarketItemPrice] = [Item: MarketItemPrice]()

    /*
    //Creates a market with inventory for the planet based on the planet's economy
    //
    */
    init(economy: Economy) {
        inventory = Inventory()
        let acceptableitems: [Item] = economy.filterItems(potentialItems: Items.getAll())
        var itemsWithQuantitiesgenerated = [Item: Int]()
        var items = [Item]()
        var counter = 0
        for item in acceptableitems {
            itemsWithQuantitiesgenerated[item] =  economy.calculateQuantity(item: item)
            items.append(item)
            counter += 1
            if !priceLog.keys.contains(item) {
                priceLog[item] = MarketItemPrice(item: item, economy: economy)
            }
        }
        self.sellGoods = items
        inventory.assign(subset: itemsWithQuantitiesgenerated)
        self.economy = economy
    }
    
    //function to add Items and quanitities to the inventory
    func assign(subset: [Item: Int]) {
        inventory.assign(subset: subset)
        for item in subset.keys {
            addItemToPriceRef(item: item)
        }
    }
    
    //Function to add the price of the Item to the inventory
    func addItemToPriceRef(item: Item) -> MarketItemPrice {
        if (priceLog[item] == nil) {
            priceLog[item] = MarketItemPrice(item: item, economy: economy)
        }
        return priceLog[item]!
    }
    
  //  Func to buyItems from the market
    func buyItems(order: Order, player: Player) -> OrderStatus {
        calculateTotalPrice(order: order, buying: true)
        var outputStatus: OrderStatus = player.canBuyItems(order: order)
        //Tester
        let contains: Bool = inventory.contains(subset: order.getOrder())
        if contains {
            calculateTotalPrice(order: order, buying: true)
            if outputStatus == OrderStatus.SUCCESS {
                if (order.getQuantity() + player.getInventory().getUsedSpace()) > ShipType.getCapacity(shipType: player.getShip().getType()) {
                    outputStatus = OrderStatus.NOT_ENOUGH_SPACE
                } else {
                    inventory.remove(subset: order.getOrder())
                    // let testContains = inventory.contains(subset: order.getOrder())
                    let credits: Int = player.getCredits()
                    
                    player.setCredits(credits: credits - order.getTotalCost())
                    player.getInventory().assign(subset: order.getOrder())
                }
            }
        } else {
            outputStatus = OrderStatus.INVALID_QUANITITY
        }
        
        return outputStatus
    }

    //Func to calculate total price of an order
    func calculateTotalPrice(order: Order, buying: Bool) {
        var totalCost = 0
        for (item, quantity) in order.getOrder() {
            var cost: Int = 0
            if buying {
                cost = (priceLog[item]?.getCurrentPrice())!
            } else {
                cost = (priceLog[item]?.getSellPrice())!
            }
            totalCost += (cost * quantity)
        }
        order.setPrice(totalCost: totalCost)
    }
    
    func getItemBuyPrice(item: Item) -> Int {
        return (priceLog[item]?.getCurrentPrice())!
    }

    func getItemSellPrice(item: Item) -> Int {
        let marketPrice: MarketItemPrice = addItemToPriceRef(item: item)
        return marketPrice.getSellPrice()
    }
    
    //Method to sell Items to market
    func sellItems(order: Order, player: Player) -> OrderStatus {
        let playerInventory: Inventory = player.getInventory()
        var outputStatus = economy.canBuyItems(order: order)
        
        if playerInventory.contains(subset: order.getOrder()) {
            calculateTotalPrice(order: order, buying: false)
            if outputStatus == .SUCCESS {
                inventory.assign(subset: order.getOrder())
                playerInventory.remove(subset: order.getOrder())
                player.setCredits(credits: player.getCredits() + order.getTotalCost())
            }
        } else {
            outputStatus = OrderStatus.INVALID_QUANITITY
        }
        return outputStatus
    }

    func getMarketInventory() -> [Item: Int] {
        return inventory.getInventory()
    }
    
    func getMarketItems() -> [Item] {
        return sellGoods
    }
    
    func getMarketPriceLog() -> [Item: MarketItemPrice] {
        return priceLog
    }
    
    func getMarketEconomy() -> Economy {
        return economy
    }
    
}
