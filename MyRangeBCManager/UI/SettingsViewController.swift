//
//  SettingsViewController.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-07.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import UIKit
import Designer

class SettingsViewController: UIViewController, Designer {

    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    @IBAction func logoutButtonClicked(_ sender: UIButton) {
        Auth.logout()
    }

    func style() {
        styleFillButton(button: logoutButton)
    }
}
