//
//  SpaceViewController.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 3/1/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import UIKit

class SpaceViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var player: Player?
//        = Player(name: "Prabir Vora", ship: Ship(type: ShipType.GNAT), config: GameConfig(difficulty: Difficulty.Beginner) , skillPoints: [Player.SkillType.ENGINEER : 4, Player.SkillType.FIGHTER: 4, Player.SkillType.PILOT: 4, Player.SkillType.TRADER: 4])
        var universe: Universe?
        var solarSystems: [SolarSystem]?
        var planets: [Planet]?
        var currentSolarSystemIndex = 0
    var currentPlanetIndex = 0
    var currentLocation: (Int, Int)? = nil
    var travelController: TravelController?
    
    let cellReusableIdentifier = "planetCell"
    
   //MARK: Solar System Specific Specific content
    @IBOutlet weak var solarSystemCollectionView: UICollectionView!
    @IBOutlet weak var solarSystemLabel: UILabel!
    @IBOutlet weak var warpButton: UIButton!
    
    //MARK: Planet Specific content
    @IBOutlet weak var selectPlanetName: UILabel!
    @IBOutlet weak var techLevelName: UILabel!
    @IBOutlet weak var planetResourceLabel: UILabel!
    @IBOutlet weak var planetLocation: UILabel!
    @IBOutlet weak var TravelAndMarketButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        universe = Universe(numberOfSolarSystems: 5)
        solarSystems = universe?.getAllSolarSystems()
        planets = solarSystems?[currentSolarSystemIndex].getPlanets()
        let solarSystemName = solarSystems?[currentSolarSystemIndex].getName()
        solarSystemLabel.text = "System: \(solarSystemName!)"
        solarSystemCollectionView.delegate = self
        solarSystemCollectionView.dataSource = self
        solarSystemCollectionView.reloadData()
        travelController = TravelController()
        player!.setCurrentSolarSystem(currSolarSystem: solarSystems![currentSolarSystemIndex])
        var isTripFree: Bool = true
        if TravelController.getTravelCounter() < 6 {
            isTripFree = true
        }
        currentLocation = travelController?.travel(entity: player!, newLocation: (planets![currentPlanetIndex].getX(), planets![currentPlanetIndex].getY()), newSolarSystem: solarSystems![currentSolarSystemIndex], isTripFree: isTripFree)
       
        updatePlanetSpecificView(planet: planets![currentSolarSystemIndex])
    }
    
    func reloadData() {
        let solarSystemName = solarSystems?[currentSolarSystemIndex].getName()
        solarSystemLabel.text = "System: \(solarSystemName!)"
        planets = solarSystems?[currentSolarSystemIndex].getPlanets()
        solarSystemCollectionView.reloadData()
        updatePlanetSpecificView(planet: planets![0])
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planets?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = solarSystemCollectionView.dequeueReusableCell(withReuseIdentifier: cellReusableIdentifier, for: indexPath) as! PlanetCell
        cell.planetNameLabel.text = planets?[indexPath.item].getName()
        cell.planetImageView.image = planets?[indexPath.item].getPlanetImage()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updatePlanetSpecificView(planet: (planets?[indexPath.item])!)
        currentPlanetIndex = indexPath.item
    }
    
    func updatePlanetSpecificView(planet: Planet) {
        selectPlanetName.text = "Planet: \(planet.getName())"
        techLevelName.text = "Tech Level: \(planet.getTechLevel().rawValue)"
        planetResourceLabel.text = "Resource: \(planet.getResource().rawValue)"
        planetLocation.text = "Location: (x: \(planet.getX()) , y: \(planet.getY()))"
        
        if planet.getX() == currentLocation!.0 && planet.getY() == currentLocation!.1 && planet.getSolarSystem() == solarSystems![currentSolarSystemIndex] {
            TravelAndMarketButton.setTitle("Visit Market", for: .normal)
        } else {
            TravelAndMarketButton.setTitle("Travel to planet", for: .normal)
        }
    }
    
    @IBAction func warp(_ sender: UIButton) {
        performSegue(withIdentifier: "warp", sender: self)
    }
    
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "warp" {
        if let destinationVC  = segue.destination as? WarpViewController {
            destinationVC.solarSystems = self.solarSystems
            destinationVC.delegate = self
        }
        
    } else if segue.identifier == "goToPlanetMarket" {
        if let destinationVC = segue.destination as? PlanetViewController {
            destinationVC.planet = planets?[currentPlanetIndex]
            destinationVC.player = player
        }
    }
    }
    
    
    
    @IBAction func travelToPlanet(_ sender: UIButton) {
        if sender.titleLabel?.text == "Visit Market" {

            performSegue(withIdentifier: "goToPlanetMarket", sender: self)
        } else {
            travel()
            updatePlanetSpecificView(planet: planets![currentPlanetIndex])
        }
        
    }
    
    func travel() {
        var isTripFree: Bool = false
        if TravelController.getTravelCounter() < 6 {
            isTripFree = true
            
            currentLocation = travelController?.travel(entity: player!, newLocation: (planets![currentPlanetIndex].getX(), planets![currentPlanetIndex].getY()), newSolarSystem: solarSystems![currentSolarSystemIndex], isTripFree: isTripFree)
            
        } else {
            isTripFree = false
            let travelCost: Int  = (travelController?.travelCost(entity: player!, newLocation: (planets![currentPlanetIndex].getX(), planets![currentPlanetIndex].getY()), newSolarSystem: solarSystems![currentSolarSystemIndex], isTripFree: isTripFree))!
            
            let alertController = UIAlertController(title: "Travel Cost Alert", message: "Total Fuel Available: \(player!.getShip().getFuel()) \n Fuel required: \(travelCost)", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Ok", style:.default) { (action) in
                self.travelOnAction()
            }
            alertController.addAction(okayAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)  { (action) in
                //
            }
                alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func travelOnAction() {
        currentLocation = travelController?.travel(entity: player!, newLocation: (planets![currentPlanetIndex].getX(), planets![currentPlanetIndex].getY()), newSolarSystem: solarSystems![currentSolarSystemIndex], isTripFree: false)
        let travelCost: Int  = (travelController?.travelCost(entity: player!, newLocation: (planets![currentPlanetIndex].getX(), planets![currentPlanetIndex].getY()), newSolarSystem: solarSystems![currentSolarSystemIndex], isTripFree: false))!
        updatePlanetSpecificView(planet: planets![currentPlanetIndex])
        
    }
    

}

extension SpaceViewController: Warp {
    func setCurrentSolarSystem(solarSystemIndex: Int) {
        self.currentSolarSystemIndex = solarSystemIndex
        reloadData()
    }
    
    
    
}
