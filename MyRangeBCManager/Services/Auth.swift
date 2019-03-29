//
//  Auth.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-06.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import Foundation
import SingleSignOn
import WebKit

class Auth {
    
    private static var authServices: AuthServices = {
        return AuthServices(baseUrl: SSO.baseUrl, redirectUri: SSO.redirectUri,
                            clientId: SSO.clientId, realm: SSO.realmName,
                            idpHint: SSO.idpHint)
    }()
    
    public static func refreshEnviormentConstants(withIdpHint: String?) {
        var idpHint = getIdpHint()
        
        if let injectedHint = withIdpHint {
            idpHint = injectedHint
        }
        
        self.authServices = AuthServices(baseUrl: SSO.baseUrl, redirectUri: SSO.redirectUri,
                                         clientId: SSO.clientId, realm: SSO.realmName,
                                         idpHint: idpHint)
    }
    
    public static func getIdpHint() -> String {
        return "idir"
    }
    
    public static func authenticate(completion: @escaping(_ success: Bool) -> Void) {
        if isAuthenticated() {
            refreshCredentials(completion: completion)
        } else {
            signIn(completion: completion)
        }
    }
    
    public static func isAuthenticated() -> Bool {
        return authServices.isAuthenticated()
    }
    
    public static func refreshCredentials(completion: @escaping(_ success: Bool) -> Void) {
        authServices.refreshCredientials(completion: { (credentials: Credentials?, error: Error?) in
            if let error = error as? AuthenticationError, case .expired = error {
                let vc = authServices.viewController() { (credentials, error) in
                    
                    if let _ = credentials, error == nil {
                        return completion(true)
                    } else {
                        let title = "Authentication"
                        let message = "Authentication didn't work. Please try again."
                        
                        Alert.show(title: title, message: message)
                        return completion(false)
                    }
                }
                guard let presenter = getCurrentViewController() else {
                    return
                }
                presenter.present(vc, animated: true, completion: nil)
                
            } else {
                return completion(true)
            }
        })
    }
    
    public static func signIn(completion: @escaping(_ success: Bool) -> Void) {
        let vc = authServices.viewController() { (credentials, error) in
            
            if let _ = credentials, error == nil {
                return completion(true)
            } else {
                let title = "Authentication"
                let message = "Authentication didn't work. Please try again."
                Alert.show(title: title, message: message)
                return completion(false)
            }
        }
        guard let presenter = getCurrentViewController() else {
            return
        }
        presenter.present(vc, animated: true, completion: nil)
    }
    
    public static func logout() {
        authServices.logout()
    }
    
    public static func hasCredentials() -> Bool {
        return authServices.credentials != nil
    }
    
    public static func getAccessToken() -> String? {
        if let creds = authServices.credentials {
            return creds.accessToken
        } else {
            return nil
        }
    }
    
    private static func getCurrentViewController() -> UIViewController? {
        guard let window = UIApplication.shared.keyWindow else {return nil}
        if var topController = window.rootViewController {
            while let presentedVC = topController.presentedViewController {
                topController = presentedVC
            }
            return topController
        } else {
            return nil
        }
    }
}
