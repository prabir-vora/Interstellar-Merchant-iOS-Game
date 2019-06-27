//
//  ProfileViewController.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/17/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var player: Player?
//        = Player(name: "Prabir Vora", ship: Ship(type: ShipType.GNAT), config: GameConfig(difficulty: Difficulty.Beginner) , skillPoints: [Player.SkillType.ENGINEER : 4, Player.SkillType.FIGHTER: 4, Player.SkillType.PILOT: 4, Player.SkillType.TRADER: 4])
    var sellGoods: [Item]? = nil
    var sellGoodsQuantity: [Item: Int]? = nil
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var shipLabel: UILabel!
    @IBOutlet weak var fuelLabel: UILabel!
    @IBOutlet weak var shipImageView: UIImageView!
    @IBOutlet weak var inventoryLabel: UILabel!
    @IBOutlet weak var inventoryTableView: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var shopButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sellGoods = player?.getSellItems()
        sellGoodsQuantity = player?.getPlayerInventory()
        inventoryTableView.delegate = self
        inventoryTableView.dataSource = self
        updateUI()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        
    }
    
    func updateUI() {
        nameLabel.text = "Name: \(player!.getName())"
        //locationLabel.text = "Current SolarSystem: \(String(describing: player?.getCurrentSolarSystem())): \(String(describing: player?.getCurrentLocation()))"
        let shipType: ShipType = player!.getShip().getType()
        shipLabel.text = "Ship: \(ShipType.toString(shipType: (player?.getShip().getType())!))"
        fuelLabel.text = "Fuel: \(player!.getShip().getFuel())"
        inventoryLabel.text = "Inventory: \(player!.getInventory().getUsedSpace()) / \(ShipType.getCapacity(shipType: shipType))"
        creditsLabel.text = "Credits: $\(player!.getCredits())"
        sellGoods = player?.getSellItems()
        sellGoodsQuantity = player?.getPlayerInventory()
        shipImageView.image = ShipType.getImage(shipType: (player?.getShip().getType())!)

        locationLabel.text = "Location: \(player!.getCurrentSolarSystem().getName()): \(player!.getCurrentLocation())"
        
        inventoryTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (sellGoods?.count)! == 0 {
//            return 1
//        }
        return (sellGoods?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if (sellGoods?.count)! == 0 {
//            let cell = inventoryTableView.dequeueReusableCell(withIdentifier: "inventoryCell", for: indexPath) as! PlayerInventoryTableViewCell
//            cell.goodQuantityLabel.text = "No Items"
//            return cell
//        }
        let cell = inventoryTableView.dequeueReusableCell(withIdentifier: "inventoryCell", for: indexPath) as! PlayerInventoryTableViewCell
        cell.goodNameLabel.text = "\(sellGoods![indexPath.row].name)"
        cell.goodQuantityLabel.text = "\(sellGoodsQuantity![sellGoods![indexPath.row]]!)"
        return cell
    }
    @IBAction func goToShop(_ sender: UIButton) {
        performSegue(withIdentifier: "goToShop", sender: self)
    }
    
        // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "goToShop" {
           if let secondVC = segue.destination as? GalacticDepotViewController {
                secondVC.player = self.player
            }
        }
    }


}
