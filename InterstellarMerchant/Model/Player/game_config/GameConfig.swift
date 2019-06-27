//
//  GameConfig.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/23/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import Foundation

public class GameConfig: NSObject, NSCoding {
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(difficulty, forKey: "Difficulty")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.difficulty = aDecoder.decodeObject(forKey: "Difficulty") as! Difficulty
    }
    
    var difficulty: Difficulty
    
    
    init(difficulty: Difficulty) {
        self.difficulty = difficulty
    }
    
    func getDifficulty() -> Difficulty {
        return difficulty
    }
    
    func setDifficulty(difficulty: Difficulty) {
        self.difficulty = difficulty
    }
    
}
