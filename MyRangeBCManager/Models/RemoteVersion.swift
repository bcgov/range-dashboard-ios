//
//  RemoteVersion.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-06.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import Foundation

class RemoteVersion {
    var ios: Int
    var idpHint: String
    var api: Int
    
    init(ios: Int, idpHint: String, api: Int) {
        self.ios = ios
        self.idpHint = idpHint
        self.api = api
    }
}
