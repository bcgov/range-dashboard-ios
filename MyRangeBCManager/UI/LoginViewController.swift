//
//  LoginViewController.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-07.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import UIKit
import Designer

class LoginViewController: UIViewController, Designer {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        Auth.signIn { (success) in
            if success {
                API.getUserInfo(completion: { (userInfo) in
                    if let user = userInfo, user.isAdmin {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        Alert.show(title: "You are not an Admin", message: "You must be an admin for MyRangeBC to use this application")
                        sender.isUserInteractionEnabled = true
                    }
                })
            } else {
                Alert.show(title: "Authentication Failed", message: "Please try again")
                sender.isUserInteractionEnabled = true
            }
        }
    }
    
    func style() {
        styleFillButton(button: loginButton)
    }
   

}
