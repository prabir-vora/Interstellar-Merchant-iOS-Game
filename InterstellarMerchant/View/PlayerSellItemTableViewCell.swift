//
//  PlayerSellItemTableViewCell.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/16/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import UIKit

protocol sellCellDelegate {
    
    func sell(item: Item, input: String)
    
}


class PlayerSellItemTableViewCell: UITableViewCell {

    private var item: Item!
    private var price: Int!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var inputAmountTextField: UITextField!
    @IBOutlet weak var sellButton: UIButton!
    
    public var delegate: sellCellDelegate?
    
    func setItem(item: Item, quantity: Int, price: Int) {
        
        itemNameLabel.text = "\(item.name) $\(price)"
        itemCountLabel.text = "/ \(quantity)"
        sellButton.layer.cornerRadius = sellButton.frame.size.height/2
        self.price = price
        self.item = item
        inputAmountTextField.text = ""
        
    }
    
    @IBAction func sell(_ sender: UIButton) {
        if let inputAmount = inputAmountTextField.text {
            delegate?.sell(item: item, input: inputAmount)
        }
    }

}
