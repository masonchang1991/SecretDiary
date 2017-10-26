//
//  LoginManager.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/7.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import Foundation
import UIKit

class LoginManager {
    
    let loginViewController: UIViewController!
    
    init(loginViewController: UIViewController) {
        
        self.loginViewController = loginViewController
        
    }
    
    
    
    func login(loginType: LoginRouter) {
        
        switch loginType {
            
        case .facebook:
            
            fbLogin()
            return
            
        case .google:
            
            googleLogin()
            return
            
        case .email:
            
            emailLogin()
            return
            
        }
        
    }
    
    
    private func fbLogin() {
        
        let client = FBLoginClient(loginViewController: loginViewController,
                                   loginManager: self)
        
        client.login()
        
        
    }
    
    private func googleLogin() {
        
        let client = GoogleLoginClient(loginViewController: loginViewController)
        
        client.login()
        
        
    }
    
    private func emailLogin() {
        
        
        
    }
    
}

extension LoginManager: FBLoginDelegate {
    
    func fbLoginManager(manager: LoginClient, didGet tokenString: String) {
        
        let firebaseLoginClient = FirebaseLoginClient(fbTokenString: tokenString,
                                                      loginViewController: loginViewController)
        
        firebaseLoginClient.login()
        
        
    }
    
    func fbLoginManager(manager: LoginClient, didFailWith error: Error?) {
        
    }
    
}

