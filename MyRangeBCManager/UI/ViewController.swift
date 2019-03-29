//
//  ViewController.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-06.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.hasCredentials() {
            API.getUserInfo(completion: { (userInfo) in
                if let user = userInfo, user.isAdmin {
                    self.showDashboard()
                } else {
                    Alert.show(title: "You are not an Admin", message: "You must be an admin for MyRangeBC to use this application")
                    Auth.logout()
                    self.showLoginPage()
                }
            })
            
        } else {
            self.showLoginPage()
        }
    }
    
    func showLoginPage() {
        if let tabViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Login") as? LoginViewController {
            self.present(tabViewController, animated: true, completion: nil)
        }
    }
    
    func showDashboard() {
        if let tabViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBar") as? UITabBarController {
            self.present(tabViewController, animated: true, completion: nil)
        }
    }


}

