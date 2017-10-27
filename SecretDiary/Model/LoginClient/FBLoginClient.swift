//
//  FBLoginClient.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/7.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class FBLoginClient: LoginClient {
    
    private(set) var loginViewController: FirebaseLoginDelegate!
    
    private(set) var delegate: FBLoginDelegate?
    
    init(loginViewController: UIViewController, loginManager: LoginManager) {
        
        guard let viewController = loginViewController as? FirebaseLoginDelegate else { return }
        
        self.loginViewController = viewController
        
        self.delegate = loginManager
        
    }
    
    func login() {
        
        guard let viewController = loginViewController as? UIViewController else {
            
            return
            
        }
        
        FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: viewController) { (result, error) in
            
            if error != nil {
                
                self.delegate?.fbLoginManager(manager: self, didFailWith: error)
            }
            
            if let tokenString = FBSDKAccessToken.current().tokenString {
                
                self.delegate?.fbLoginManager(manager: self, didGet: tokenString)
                
            }
        }
    }
}
