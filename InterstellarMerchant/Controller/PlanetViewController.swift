//
//  PlanetViewController.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/6/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import UIKit



class PlanetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, buyCellDelegate, sellCellDelegate {

    var player: Player? 
    var planet: Planet? = nil
    var planetMarket: Market? = nil
    var buyGoods: [Item]? = nil
    var buyGoodsQuanitity: [Item: Int]? = nil
    var buyPriceLog: [Item: MarketItemPrice]? = nil
    var playerInventoryItems: [Item]? = nil
    var playerInventoryItemsAndQuantities: [Item: Int]? = nil
    var sellGoods: [Item]? = nil
    var sellGoodsQuantity: [Item: Int]? = nil
    var sellPriceLog: [Item: Int]? = nil
    
    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var playerCreditsLabel: UILabel!
    @IBOutlet weak var marketTableView: UITableView!
    @IBOutlet weak var travelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        marketTableView.allowsSelection = false
        planetNameLabel.text = self.planet?.getName()
        planetMarket = self.planet?.getPlanetMarket()
        buyGoods = planetMarket?.getMarketItems()
        buyGoodsQuanitity = planetMarket?.getMarketInventory()
        buyPriceLog = planetMarket?.getMarketPriceLog()
        //Test code for player inventory
        var playerInventory = player?.getInventory()
        playerInventoryItems = player?.getSellItems()
        playerInventoryItemsAndQuantities = player?.getPlayerInventory()
        sellGoods = planetMarket?.getMarketEconomy().filterItems(potentialItems: playerInventoryItems!)
        sellGoodsQuantity = [:]
        for (key, value) in playerInventoryItemsAndQuantities! {
            if (sellGoods?.contains(key))! {
                sellGoodsQuantity![key]  = value
            }
        }
        sellPriceLog = [:]
        for item in sellGoods! {
            sellPriceLog![item] = buyPriceLog![item]?.getSellPrice()
                //planetMarket?.getMarketEconomy().calculatePrice(item: item)
        }
        marketTableView.delegate = self
        marketTableView.dataSource = self
        updateCredits()
        
        
    }
    
    func updateCredits() {
        playerCreditsLabel.text = "$\(player!.getCredits())"
    }
    
    //MARK: Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
           return "Buy Goods"
        }
        return "Sell Goods"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (buyGoods?.count)!
        }
        return (sellGoods?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = marketTableView.dequeueReusableCell(withIdentifier: "marketCell", for: indexPath) as! MarketTableViewCell
            cell.setItem(item: buyGoods![indexPath.row], quantity: (buyGoodsQuanitity?[buyGoods![indexPath.row]])!, price: buyPriceLog![buyGoods![indexPath.row]]!)
            cell.delegate = self
            return cell
        case 1:
            let cell = marketTableView.dequeueReusableCell(withIdentifier: "sellCell", for: indexPath) as! PlayerSellItemTableViewCell
            cell.setItem(item: sellGoods![indexPath.row], quantity: (sellGoodsQuantity?[sellGoods![indexPath.row]])!, price: sellPriceLog![sellGoods![indexPath.row]]!)
            cell.delegate = self
            return cell
        default: break
        }
        return UITableViewCell()
    }
    
    
    func buy(item: Item, input: String) {
        
        print("Buy method executing \(item.name)")
        if let buyAmount = Int(input) {
            let order: Order = Order(order: [item: buyAmount])
            
            let orderStatus: OrderStatus = (planetMarket?.buyItems(order: order, player: player!))!
            
            if orderStatus != OrderStatus.SUCCESS {
                let alertController = UIAlertController(title: "Order Not successful", message: "Error: \(orderStatus.rawValue)", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Ok", style:.default) { (action) in
                }
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Order Successful", message: "Congrats", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Ok", style:.default) { (action) in
                }
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                updateCredits()
                updateVariables()
                marketTableView.reloadData()
            }
        } else {
            let alertController = UIAlertController(title: "Invalid Purchase", message: "Invalid Purchase Amount", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Ok", style:.default) { (action) in
                //
            }
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
        }
        print(player!.getCredits())
    }
    
    func sell(item: Item, input: String) {
        if let sellAmount = Int(input) {
            let order: Order = Order(order: [item: sellAmount])
            let orderStatus: OrderStatus = (planetMarket?.sellItems(order: order, player: player!))!
            if orderStatus != OrderStatus.SUCCESS {
                let alertController = UIAlertController(title: "Order Not successful", message: "Error: \(orderStatus.rawValue)", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Ok", style:.default) { (action) in
                }
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Order Successful", message: "Congrats", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Ok", style:.default) { (action) in
                }
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                updateCredits()
                updateVariables()
                marketTableView.reloadData()
            }
        } else {
            let alertController = UIAlertController(title: "Invalid Purchase", message: "Invalid Purchase Amount", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Ok", style:.default) { (action) in
                //
            }
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func updateVariables() {
        buyGoods = planetMarket?.getMarketItems()
        buyGoodsQuanitity = planetMarket?.getMarketInventory()
        buyPriceLog = planetMarket?.getMarketPriceLog()
        
        playerInventoryItems = player?.getSellItems()
        playerInventoryItemsAndQuantities = player?.getPlayerInventory()
        sellGoods = planetMarket?.getMarketEconomy().filterItems(potentialItems: playerInventoryItems!)
        for (key, value) in playerInventoryItemsAndQuantities! {
            if (sellGoods?.contains(key))! {
                sellGoodsQuantity![key]  = value
            }
        }
        for item in sellGoods! {
            //sellPriceLog![item] = planetMarket?.getMarketEconomy().calculatePrice(item: item)
            sellPriceLog![item] = buyPriceLog![item]?.getSellPrice()
        }
        
        
    }
    
    
    
    @IBAction func travel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
