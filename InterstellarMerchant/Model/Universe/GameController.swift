//
//  GameController.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/19/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import Foundation

class GameController: NSObject, NSCoding {
    
    enum Keys: String {
        case universe =  "Universe"
        case player = "Player"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(universe, forKey: Keys.universe.rawValue)
        aCoder.encode(player, forKey: Keys.player.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.universe = aDecoder.decodeObject(forKey: Keys.universe.rawValue) as! Universe
        self.player = aDecoder.decodeObject(forKey: Keys.player.rawValue) as! Player
        
        super.init()
    }
    

    let universe: Universe
    let player: Player

    init(universe: Universe, player: Player) {
        self.universe = universe
        self.player = player
        
        super.init()
    }


}
