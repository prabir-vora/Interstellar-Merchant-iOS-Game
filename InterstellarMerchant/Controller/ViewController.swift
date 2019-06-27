//
//  ViewController.swift
//  InterstellarMerchant
//
//  Created by Prabir Vora on 2/16/19.
//  Copyright © 2019 Prabir Vora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        continueButton.layer.cornerRadius = continueButton.frame.size.height/2
    }


}

