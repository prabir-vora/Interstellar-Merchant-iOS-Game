//
//  BuyShipCollectionViewCell.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/29/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import UIKit

protocol buyShipDelegate {
    func buyShip(shipType: ShipType)
}


class BuyShipCollectionViewCell: UICollectionViewCell {
    
    var shipType: ShipType?
    var delegate: buyShipDelegate?
    
    @IBOutlet weak var shipImage: UIImageView!
    @IBOutlet weak var shipNameLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    
    @IBAction func buyShip(_ sender: UIButton) {
        delegate?.buyShip(shipType: self.shipType!)
    }
    
}
