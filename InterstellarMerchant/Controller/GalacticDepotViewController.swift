//
//  GalacticDepotViewController.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/29/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import UIKit

class GalacticDepotViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, buyShipDelegate {


    var player: Player?
    var ships: [ShipType] = ShipType.cases
    var shipCosts: [ShipType: Int] = ShipType.getCost()
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var fuelBuyButton: UIButton!
    
    @IBOutlet weak var buyShipCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buyShipCollectionView.delegate = self
        buyShipCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ships.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = buyShipCollectionView.dequeueReusableCell(withReuseIdentifier: "buyShipCell", for: indexPath) as! BuyShipCollectionViewCell
        cell.shipImage.image = ShipType.getImage(shipType: ships[indexPath.item])
        cell.shipType = ships[indexPath.item]
        cell.shipNameLabel.text = "\(ShipType.toString(shipType: ships[indexPath.item])) (\(ShipType.getCapacity(shipType: ships[indexPath.item])))"
        if let shipCost = shipCosts[ships[indexPath.item]] {
            if shipCost == 0 {
                cell.buyButton.setTitle("Equip", for: .normal)
            } else {
                cell.buyButton.setTitle("Buy $\(shipCost)", for: .normal)
            }
        }
        cell.delegate = self 
        return cell
    }
    
    func buyShip(shipType: ShipType) {
        if (player?.getCredits())! < shipCosts[shipType]! {
            let alertController = UIAlertController(title: "Purchase Unsucessful", message: "Not Enough Credits", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Ok", style:.default) { (action) in
                //
            }
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
        } else {
            player?.setCredits(credits: (player?.getCredits())! - shipCosts[shipType]!)
            player?.setCurrentShip(type: shipType)
            let alertController = UIAlertController(title: "Purchase Sucessful", message: "", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Ok", style:.default) { (action) in
                //
            }
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
        }
    }

    
    @IBAction func buyFuel(_ sender: UIButton) {
        if (player?.getCredits())! < 50 {
            let alertController = UIAlertController(title: "Purchase Unsucessful", message: "Not Enough Credits", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Ok", style:.default) { (action) in
                //
            }
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
        } else {
            player?.setCredits(credits: (player?.getCredits())! - 50)
            player?.getShip().addFuel(fuelAmount: 1000)
            let alertController = UIAlertController(title: "Purchase Sucessful", message: "1000 fuel added", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Ok", style:.default) { (action) in
                //
            }
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
