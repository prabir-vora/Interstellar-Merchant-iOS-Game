//
//  Planet Attributes.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/25/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import Foundation

public enum Tech: String  {
    case AGRICULTURE, MEDIEVAL, RENAISSANCE, EARLY_INDUSTRIAL, INDUSTRIAL, POST_INDUSTRIAL, HI_TECH

    static func getRandomTech() -> Tech {
        let all: [Tech] = [AGRICULTURE, MEDIEVAL, RENAISSANCE, EARLY_INDUSTRIAL, INDUSTRIAL, POST_INDUSTRIAL, HI_TECH]
        let randomIndex = Int(arc4random()) % all.count
        return all[randomIndex]
    }
    
    static func compare(tech1: Tech, tech2: Tech) -> Int {
        let level: [Tech: Int] = [Tech.AGRICULTURE: 0, Tech.MEDIEVAL: 1, Tech.RENAISSANCE: 2, Tech.EARLY_INDUSTRIAL: 3, Tech.INDUSTRIAL: 4, Tech.POST_INDUSTRIAL: 5, Tech.HI_TECH : 6]
        return level[tech1]! - level[tech2]!
    }
}


public enum Resource: String {
    case NOSPECIALRESOURCES, MINERALRICH, MINERALPOOR, DESERT, LOTSOFWATER, RICHSOIL, POORSOIL,
    RICHFAUNA, LIFELESS, WEIRDMUSHROOMS, LOTSOFHERBS, ARTISTIC, WARLIKE
    
    static func getRandomResource() -> Resource {
        let all: [Resource] = [MINERALRICH, MINERALPOOR, DESERT, LOTSOFWATER, RICHSOIL, POORSOIL,
                               RICHFAUNA, LIFELESS, WEIRDMUSHROOMS, LOTSOFHERBS, ARTISTIC, WARLIKE]
        let randomIndex = Int(arc4random()) % all.count
        
        let oneOrZero = Int.random(in: 0...1)
        if oneOrZero == 0 {
            return Resource.NOSPECIALRESOURCES
        } else {
            return all[randomIndex]
        }
    }
    
}
