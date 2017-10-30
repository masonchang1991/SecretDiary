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
    
    private(set) var googleIdToken: String?
    
    private(set) var loginType: LoginRouter
    
    private(set) var delegate: FirebaseLoginDelegate?
    
    private(set) var userData: [String: String] = [:]
    
    init(fbTokenString: String, loginViewController: UIViewController, userData: [String: String]) {
        
        self.loginType = .facebook
        
        guard let viewController = loginViewController as? FirebaseLoginDelegate else {
            return
        }
        
        self.accessToken = fbTokenString
        
        self.userData = userData
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        if let uid = Auth.auth().currentUser?.uid {
            
            if let name = self.userData["name"] {
            
                appDelegate?.user = User(name: name, uid: uid)
                
            }
            
        }
        
        self.delegate = viewController
        
    }
    
    init(googleIdTokenString: String, googleAccessTokenString: String, loginViewController: UIViewController?, userData: [String: String]) {
        
        self.accessToken = googleAccessTokenString
        
        self.googleIdToken = googleIdTokenString
        
        self.delegate = loginViewController as? FirebaseLoginDelegate
        
        self.userData = userData
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        if let uid = Auth.auth().currentUser?.uid {
            
            if let name = self.userData["name"] {
                
                appDelegate?.user = User(name: name, uid: uid)
                
            }
            
        }
        
        self.loginType = .google
        
    }
    
    func login() {
        
        switch loginType {
            
        case .facebook:
            fbLogin(accessToken: accessToken)
            return
            
        case .google:
            googleLogin(googleIdTokenString: googleIdToken, googleAccessTokenString: accessToken)
            return
            
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
                
                let userRef = Database.database().reference()
                
            userRef.child("Users").child(user!.uid).child("User").setValue(self.userData)
                
                self.delegate?.firebaseLogin(loginClient: self,
                                             didSuccessWith: LoginRouter.facebook)
                
            }
        }
    }
    
    func googleLogin(googleIdTokenString: String?, googleAccessTokenString: String?) {
        
         guard
            let idTokenString = googleIdTokenString,
            let accessTokenString = googleAccessTokenString else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idTokenString,
                                                       accessToken: accessTokenString)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            
            if let error = error {
               
                self.delegate?.firebaseLogin(loginClient: self,
                                             didFailWith: error)
                
                return
            }
            // User is signed in
            
            let userRef = Database.database().reference()
            
            userRef.child("Users").child(user!.uid).child("User").setValue(self.userData)
            
            self.delegate?.firebaseLogin(loginClient: self,
                                         didSuccessWith: LoginRouter.google)
            
        }
        
    }
    
    
}

protocol FirebaseLogin {
    
    func fbLogin(accessToken: String?)
    
    func googleLogin(googleIdTokenString: String?, googleAccessTokenString: String?)
    
}


