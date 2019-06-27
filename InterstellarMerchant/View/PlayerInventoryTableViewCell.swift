//
//  PlayerInventoryTableViewCell.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/27/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import UIKit

class PlayerInventoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var goodNameLabel: UILabel!
    @IBOutlet weak var goodQuantityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
