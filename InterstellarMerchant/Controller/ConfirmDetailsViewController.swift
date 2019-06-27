//
//  ConfirmDetailsViewController.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/25/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import UIKit

class ConfirmDetailsViewController: UIViewController {

//    var filePath: String {
//        //1 - manager lets you examine contents of a files and folders in your app; creates a directory to where we are saving it
//        let manager = FileManager.default
//        //2 - this returns an array of urls from our documentDirectory and we take the first path
//        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
//        print("this is the url path in the documentDirectory \(url!)")
//        //3 - creates a new path component and creates a new file called "Data" which is where we will store our Data array.
//        return (url!.appendingPathComponent("Data").path)
//    }
    
    var player: Player? 
    
    //MARK: Variables
    var name: String = ""
    var pilotSkills: Int  = 0
    var fighterSkills: Int = 0
    var traderSkills: Int = 0
    var engineerSkills: Int = 0
    var difficulty: Difficulty = .Beginner
    var spaceShip: String = "Gnat"
    var credits: Int = 1000
    
    @IBOutlet weak var pilotLabel: UILabel!
    @IBOutlet weak var fighterLabel: UILabel!
    @IBOutlet weak var traderLabel: UILabel!
    @IBOutlet weak var engineerLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var spaceShipLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        // Do any additional setup after loading the view.
        pilotLabel.text = "Pilot: \(pilotSkills)"
        fighterLabel.text = "Fighter: \(fighterSkills)"
        engineerLabel.text = "Engineer: \(engineerSkills)"
        traderLabel.text = "Trader: \(traderSkills)"
        difficultyLabel.text = "Difficulty Level: \(difficulty.rawValue)"
        creditsLabel.text = "Credits: 1000"
        spaceShipLabel.text = "Spaceship: Gnat"
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let barVC = segue.destination as? GameTabBarController {
            barVC.viewControllers?.forEach {
                if let vc = $0 as? SpaceViewController {
                    vc.player = self.player
                }
                
                if let vc = $0 as? ProfileViewController {
                    vc.player = self.player
                }
                
            }
        }
        
    }
 
    
    @IBAction func createUser(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToGame", sender: self)
        
    }
    
//    func save(player: Player) {
//        let randomFilename = UUID().uuidString
//        let fullPath = getDocumentsDirectory().appendingPathComponent(randomFilename)
//
//        do {
//            let data = try NSKeyedArchiver.archivedData(withRootObject: player, requiringSecureCoding: false)
//            try data.write(to: fullPath)
//        } catch {
//            print("Couldn't write file")
//        }
//    }
//
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
    
    

}
