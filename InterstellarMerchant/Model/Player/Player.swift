
//  Player.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/23/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.


public class Player: Location {
    
    
    func getX() -> Int {
        return xCoord ?? 0
    }
    
    func getY() -> Int {
        return yCoord ?? 0
    }
    
    
    public let MAXIMUM_POINTS = 16
    public let STARTING_CREDITS = 1000
    private var climate: String
    private var config: GameConfig
    private var credits: Int = 0
    private var ship: Ship
    private var name: String
    private var skillPoints: [Int]
    private var xCoord: Int? = nil
    private var yCoord: Int? = nil
    
    init(climate: String, config: GameConfig, credits: Int, ship: Ship, name: String, skillPoints: [Int]) {
        self.climate = climate
        self.config = config
        self.ship = ship
        self.name = name
        self.skillPoints = skillPoints
    }
    
    private var market: Market
    
    
}
