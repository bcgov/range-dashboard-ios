//
//  API.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-06.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Reachability

class API {
    
    static func headers() -> HTTPHeaders {
        if let token = Auth.getAccessToken() {
            return ["Authorization": "Bearer \(token)"]
        } else {
            return ["Content-Type" : "application/json"]
        }
    }
    
    static func put(endpoint: URL, params: [String:Any], completion: @escaping (_ response: DataResponse<Any>? ) -> Void) {
        var request = URLRequest(url: endpoint)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        if let token = Auth.getAccessToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
        request.httpBody = data
        
        
        // Manual 20 second timeout for each call
        var completed = false
        var timedOut = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
            if !completed {
                timedOut = true
                return completion(nil)
            }
        }
        
        Alamofire.request(request).responseJSON { response in
            completed = true
            if timedOut {return}
            if let responseJSON = JSON(response.result.value) as? JSON, let error = responseJSON["error"].string {
                print("PUT ERROR:")
                print(error)
            }
            if let rsp = response.response {
                print("PUT Request received status code \(rsp.statusCode).")
            }
            return completion(response)
        }
    }
    
    static func get(endpoint: URL, completion: @escaping (_ response: JSON?) -> Void) {
        // Manual 20 second timeout for each call
        var completed = false
        var timedOut = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
            if !completed {
                timedOut = true
                return completion(nil)
            }
        }
        Alamofire.request(endpoint, method: .get, headers: headers()).responseData { (response) in
            completed = true
            if timedOut {return}
            if response.result.description == "SUCCESS", let value = response.result.value {
                let json = JSON(value)
                if let error = json["error"].string {
                    print( "GET call rejected:")
                    print( "Endpoint: \(endpoint)")
                    print( "Error: \(error)")
                    return completion(nil)
                } else {
                    // Success
                    return completion(json)
                }
            } else {
                print( "GET call failed:")
                print( "Endpoint: \(endpoint)")
                return completion(nil)
            }
        }
    }
    
    static func updateRemoteVersion(ios: Int, idphint: String, completion: @escaping (_ success: Bool,_ error: String) -> Void) {
        guard let r = Reachability(), r.connection != .none else {
            print("Could not update remote versions: app is offline.")
            return completion(false, "Application is offline")
        }
        checkUserAccess { (isAdmin) in
            if !isAdmin {
                print("User is not admin.")
                return completion(false, "Only admins can make this change")
            }
            
            guard let endpoint = URL(string: Constants.API.versionPath, relativeTo: Constants.API.baseURL) else {
                return completion(false, "Could not get endpoint")
            }
            
            var params: [String:Any]  = [String:Any]()
            params["ios"] = ios
            params["idpHint"] = idphint
            API.put(endpoint: endpoint, params: params) { (response) in
                if let rsp = response, !rsp.result.isFailure {
                    NotificationCenter.default.post(name: .versionsChanged, object: nil)
                    return completion(true, "")
                } else {
                    return completion(false, "Server error")
                }
            }
        }
        
    }
    
    static func loadRemoteVersion(completion: @escaping (_ result: RemoteVersion?) -> Void) {
        guard let r = Reachability(), r.connection != .none else {
            print("Could not load remote versions: app is offline.")
            return completion(nil)
        }
        guard let endpoint = URL(string: Constants.API.versionPath, relativeTo: Constants.API.baseURL) else {
            return completion(nil)
        }
        print("Fetching remote versions...")
        API.get(endpoint: endpoint) { (responseJSON) in
            guard let json = responseJSON else {
                print("Could not fetch remote versions.")
                return completion(nil)
            }
            
            if let iOSVersion = json["ios"].int, let apiVersion = json["api"].int {
                var idphintString = Auth.getIdpHint()
                print("Received:")
                print("API: \(apiVersion)")
                print("iOS: \(iOSVersion)")
                if let remoteIdphint = json["idpHint"].string {
                    idphintString = remoteIdphint
                    print("idphint: \(remoteIdphint)")
                }
                return completion(RemoteVersion(ios: iOSVersion, idpHint: idphintString, api: apiVersion))
            } else {
                print("Remote versions could not be read.")
                return completion(nil)
            }
        }
    }
    
    static func getUserInfo(completion: @escaping(_ userInfo: UserInfo?) -> Void) {
        guard let endpoint = URL(string: Constants.API.userInfoPath, relativeTo: Constants.API.baseURL) else {
            return completion(nil)
        }
        
        API.get(endpoint: endpoint) { (jsonResponse) in
            guard let infoJSON = jsonResponse else { return completion(nil) }
            if let isNull = infoJSON.null {
                return completion(nil)
            } else {
                return completion(UserInfo(from: infoJSON))
            }
        }
    }
    
    static func checkUserAccess(completion: @escaping(_ isAdmin: Bool) -> Void) {
        getUserInfo { (info) in
            guard let userInfo = info else {return completion(false)}
            return completion(userInfo.isAdmin)
        }
    }
}
