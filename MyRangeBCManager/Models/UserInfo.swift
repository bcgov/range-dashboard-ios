//
//  UserInfo.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-07.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserInfo {
    // ID of -1 == invalid. Unlikely to happen.
    var id: Int
    var username: String?
    var clientId: Int?
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phoneNumber: String?
    var active: Bool?
    var isAdmin: Bool = false
    
    init(id: Int) {
        self.id = id
    }
    
    init(from json: JSON) {
        if let id = json["id"].int {
            self.id = id
        } else {
            // Unlikely to happen.
            self.id = -1
        }
        
        if let username = json["username"].string {
            self.username = username
        }
        
        if let clientId = json["clientId"].int {
            self.clientId = clientId
        }
        
        if let givenName = json["givenName"].string {
            self.firstName = givenName
        }
        
        if let familyName = json["familyName"].string {
            self.lastName = familyName
        }
        
        if let email = json["email"].string {
            self.email = email
        }
        
        if let phoneNumber = json["phoneNumber"].string {
            self.phoneNumber = phoneNumber
        }
        
        if let active = json["active"].bool {
            self.active = active
        }
        
        //TODO: Remove the line below and uncomment the code under it
//        self.isAdmin = true
        
        if let roles = json["roles"].array {
            for role in roles {
                if let roleString = role.string, roleString.lowercased() == "myra_admin" {
                    self.isAdmin = true
                    break
                }
            }
        }
        
    }
}
