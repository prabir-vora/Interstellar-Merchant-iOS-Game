//
//  Economy.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/1/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import Foundation


protocol Economy {
    
    /**
     * Can the host economy buy the item from the player
     * @param order - the order of items the user is trying to sell
     * @return whether the order can proceed or not
     */
    func canBuyItems(order: Order) -> OrderStatus
    
    /**
     * Can the host economy buy the item from the player
     * @param item - the item
     * @param quantity - the quantity
     * @return whether the order can proceed or not
     */
    
    
    /**
     * Calculates the price of the item based on the economy for the market
     * @param item - the item
     * @return - the item price
     */
    func calculatePrice(item: Item) -> Int
    
    /**
     * Filters items from the potential items. Basically determines what items are sold
     * at the market
     * @param potentialItems - potential items within the economy
     * @return the items that will be in the market
     */
    func filterItems(potentialItems: [Item]) -> [Item]
    
    /**
     * Calculates the quantity for the item that should exist in the market
     * @param item - the item to calculate the quantity for
     * @return the quantity of the item
     */
    func calculateQuantity(item: Item) -> Int
    
}
