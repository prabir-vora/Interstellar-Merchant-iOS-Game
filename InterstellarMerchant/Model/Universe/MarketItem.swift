//
//  MarketItem.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/1/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

public class MarketItemPrice {
    private let item: Item
    private let economy: Economy
    private let sellPriceFactor = 0.98
    private var priceHistory = [Int]() //Keeps track of old prices
    private var sellPriceHistory =  [Int]() // keeps track of sell prices
    private var price: Int?
    private var sellPrice: Int? = nil // the price the store is willing to pay for the item
    
    init(item: Item, economy: Economy) {
        //self.price = economy.calculatePrice(item: item)
        self.item = item
        self.economy = economy
        updatePrice()
    }
    
    func updatePrice() -> Int? {
        if let currPrice = self.price {
            // if price is not null, then sell price is not null
            priceHistory.append(currPrice) // throw exception if price is null
            sellPriceHistory.append(self.sellPrice!) // throw exception if sell price is null
        }
        price = calculatePrice()
        sellPrice = calculateSellPrice(buyPrice: price)
        return price
    }
    
    func calculatePrice() -> Int {
        return economy.calculatePrice(item: item)
    }
    
    func calculateSellPrice(buyPrice: Int?) -> Int {
        return Int(Double(buyPrice!) * sellPriceFactor)
    }
    
    func getSellPrice() -> Int {
        return sellPrice!
    }
    
    func getCurrentPrice() -> Int {
        return price!
    }
}
