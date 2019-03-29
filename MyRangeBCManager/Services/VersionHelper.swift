//
//  VersionHelper.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-13.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import Foundation

enum VersionState {
    case Testing
    case Production
    case Unknown
}

class VersionHelper {
    static let shared = VersionHelper()
    private init() {}
    
    func getBuildNumber(from version: RemoteVersion) -> Int {
        let buildNumber = getVersionNumber(from: version)
        return version.ios - (buildNumber * 1000)
    }
    
    func getVersionNumber(from version: RemoteVersion) -> Int {
        return Int(version.ios / 1000)
    }
    
    func createRemoteVersionFrom(version: Int, build: Int) -> Int {
        return (version * 1000) + build
    }
    
    func getBuildAndVersionNumber(completion: @escaping(_ build: Int,_ version: Int) -> Void) {
        API.loadRemoteVersion { (result) in
            var version = 0
            var build = 0
            if let remoteVersion = result {
                build = self.getBuildNumber(from: remoteVersion)
                version = self.getVersionNumber(from: remoteVersion)
            }
            return completion(build, version)
        }
    }
    
    func getVersionState(completion: @escaping(_ state: VersionState) -> Void) {
        API.loadRemoteVersion { (result) in
            if let version = result {
                if version.idpHint.lowercased() == "bceid" {
                    return completion(.Testing)
                } else if version.idpHint.lowercased() == "idir" {
                    return completion(.Production)
                }
                
                return completion(.Unknown)
            }
        }
    }
}
