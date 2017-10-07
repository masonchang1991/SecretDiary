//
//  FirebaseLoginClient.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/7.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseLoginClient: LoginClient, FirebaseLogin {
    
    private(set) var accessToken: String?
    
    private(set) var loginType: LoginRouter
    
    private(set) var delegate: FirebaseLoginDelegate?
    
    init(fbTokenString: String, loginViewController: FirebaseLoginDelegate) {
        
        self.accessToken = fbTokenString
        
        self.loginType = .facebook
        
        self.delegate = loginViewController
        
    }
    
    init(googleTokenString: String) {
        
        self.accessToken = googleTokenString
        
        self.loginType = .google
        
    }
    
    func login() {
        
        switch loginType {
            
        case .facebook:
            fbLogin(accessToken: accessToken)
            return
            
        case .google: return
            
        case .email: return
        
        }
        
    }
    
    func fbLogin(accessToken: String?) {
        
        guard let tokenString = accessToken else { return }
        
        let credentials =
            FacebookAuthProvider.credential(withAccessToken: tokenString)
        
        Auth.auth().signIn(with: credentials) { (user, error) in
            
            if error != nil {
                
                self.delegate?.firebaseLogin(loginClient: self,
                                             didFailWith: error)
                
            } else {
                
                self.delegate?.firebaseLogin(loginClient: self,
                                             didSuccessWith: LoginRouter.facebook)
                
            }
        }
    }
    
    
    
    
    
    
}

protocol FirebaseLogin {
    
    func fbLogin(accessToken: String?)
    
}


