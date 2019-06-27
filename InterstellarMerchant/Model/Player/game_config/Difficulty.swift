//
//  Difficulty.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/23/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import Foundation


public enum Difficulty: String {
    case Beginner
    case Easy
    case Normal
    case Hard
    case Impossible
    
    static func getDifficulties() -> [Difficulty] {
        return [.Beginner, .Easy,  .Normal, .Hard, .Impossible]
    }
    
}
