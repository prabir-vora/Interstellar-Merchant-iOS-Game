//
//  EnterDetailsViewController.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/25/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import UIKit

class EnterDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var player: Player?
    //MARK: Variables
    
    let myPickerData = Difficulty.getDifficulties()
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pilotStepper: UIStepper!
    @IBOutlet weak var traderStepper: UIStepper!
    @IBOutlet weak var fighterStepper: UIStepper!
    @IBOutlet weak var engineerStepper: UIStepper!
    @IBOutlet weak var pilotlabel: UILabel!
    @IBOutlet weak var traderLabel: UILabel!
    @IBOutlet weak var fighterlabel: UILabel!
    @IBOutlet weak var engineerLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var difficultyTextField: UITextField!
    var difficultyLevel: Difficulty = .Beginner
    
    var pilotSkills: Int = 0 {
        didSet {
            pilotlabel.text = "\(pilotSkills)"
        }
    }
    
    var traderSkills: Int = 0 {
        didSet {
            traderLabel.text = "\(traderSkills)"
        }
    }
    var fighterSkills: Int = 0 {
        didSet {
            fighterlabel.text = "\(fighterSkills)"
        }
    }
    
    var engineerSkills: Int = 0 {
        didSet {
            engineerLabel.text = "\(engineerSkills)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pilotStepper.wraps = true
        pilotStepper.autorepeat = true
        pilotStepper.maximumValue = 10
        
        traderStepper.wraps = true
        traderStepper.autorepeat = true
        traderStepper.maximumValue = 10
        
        fighterStepper.wraps = true
        fighterStepper.autorepeat = true
        fighterStepper.maximumValue = 10
        
        engineerStepper.wraps = true
        engineerStepper.autorepeat = true
        engineerStepper.maximumValue = 10
        
        let thePicker = UIPickerView()
        difficultyTextField.inputView = thePicker
        thePicker.delegate = self

        
        
        
        // Do any additional setup after loading the view.
    }
    //MARK: Steppers
    
    @IBAction func updatePilotSkills(_ sender: UIStepper) {
        pilotSkills = (Int) (sender.value)
    }
    
    @IBAction func updateTraderSkills(_ sender: UIStepper) {
        traderSkills = (Int) (sender.value)
    }
    
    @IBAction func updateFighterSkills(_ sender: UIStepper) {
        fighterSkills = (Int) (sender.value)
    }
    
    @IBAction func updateEngineerSkills(_ sender: UIStepper) {
        engineerSkills = (Int) (sender.value)
    }
    
    
    // MARK: Continue
    @IBAction func confirmDetails(_ sender: UIButton) {
        if (16 - pilotSkills - traderSkills - fighterSkills - engineerSkills != 0) {
            let alertController = UIAlertController(title: "Invalid Skills", message: "Total skills not 16", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Ok", style:.default) { (action) in
                //
            }
            
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            
        } else if (nameTextField.text?.count == 0) {
            let alertController = UIAlertController(title: "Invalid Name", message: "", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Ok", style:.default) { (action) in
                //
            }
            
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
        } else {
            
            
            player = Player(name: (nameTextField?.text)!, ship: Ship(type: ShipType.GNAT), config: GameConfig(difficulty: difficultyLevel), skillPoints: [Player.SkillType.PILOT : pilotSkills, Player.SkillType.TRADER : traderSkills, Player.SkillType.FIGHTER: fighterSkills, Player.SkillType.ENGINEER: engineerSkills])
            performSegue(withIdentifier: "continueToConfirm", sender: self)
        }
        
        
    }
    
    // MARK: Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Difficulty.getDifficulties().count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row].rawValue
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        difficultyTextField.text = myPickerData[row].rawValue
        difficultyLevel = myPickerData[row]
    }
    
    
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "continueToConfirm" {
            let secondVC = segue.destination as! ConfirmDetailsViewController
            secondVC.name = nameTextField.text!
            secondVC.difficulty = difficultyLevel
            secondVC.pilotSkills = self.pilotSkills
            secondVC.fighterSkills = self.fighterSkills
            secondVC.engineerSkills = self.engineerSkills
            secondVC.traderSkills = self.traderSkills
            
            secondVC.player = self.player
            
        }
//      Get the new view controller using segue.destination.
//      Pass the selected object to the new view controller.
     }
    
}
