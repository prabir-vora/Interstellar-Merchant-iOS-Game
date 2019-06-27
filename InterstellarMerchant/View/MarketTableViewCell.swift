//
//  MarketTableViewCell.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/6/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import UIKit

protocol buyCellDelegate {
    
    func buy(item: Item, input: String)
    
}

class MarketTableViewCell: UITableViewCell {

    private var item: Item!
    private var price: MarketItemPrice!
    private var planet: Planet!
    public var delegate: buyCellDelegate?
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var inputAmountTextField: UITextField!
    @IBOutlet weak var buyButton: UIButton!
    
    func setItem(item: Item, quantity: Int, price: MarketItemPrice) {
 
        itemNameLabel.text = "\(item.name) $\(price.getCurrentPrice())"
        itemCountLabel.text = "/ \(quantity)"
        buyButton.layer.cornerRadius = buyButton.frame.size.height/2
        self.price = price
        self.item = item
        inputAmountTextField.text = ""
    }
    
    @IBAction func placeBuyOrder(_ sender: UIButton) {
        if let inputAmount = inputAmountTextField.text {
            delegate?.buy(item: item, input: inputAmount)
        } 
    }
    
    
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
