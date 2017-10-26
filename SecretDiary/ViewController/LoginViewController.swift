//
//  ViewController.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/7.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var contentView: LoginView!
    
    var loginManager: LoginManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginManager = LoginManager(loginViewController: self)
        
        contentView.fbLoginButton.addTarget(self,
                                            action: #selector(fbLogin),
                                            for: .touchUpInside)
        
        contentView.googleLoginButton.addTarget(self,
                                                action: #selector(googleLogin),
                                                for: .touchUpInside)
        
        contentView.phoneLoginButton.addTarget(self,
                                               action: #selector(phoneLogin),
                                               for: .touchUpInside)

    }
    
    @objc func fbLogin() {
        
        loginManager?.login(loginType: .facebook)
        
    }
    
    @objc func googleLogin() {
        
        loginManager?.login(loginType: .google)
        
    }
    
    @objc func phoneLogin() {
        
        guard let deviceID = UIDevice.current.identifierForVendor?.uuidString else {
            return
        }
        
        Auth.auth().signIn(withCustomToken: deviceID) { (user, error) in
            // ...
            
            if error != nil {
                
                print(error)
                
            } else {
                
                print(user?.providerID)
                
            }
            
        }
        
    }
    
}

extension LoginViewController: FirebaseLoginDelegate {
    
    func firebaseLogin(loginClient: FirebaseLoginClient, didSuccessWith loginType: LoginRouter) {
        
        print(loginType)
        
    }
    
    func firebaseLogin(loginClient: FirebaseLoginClient, didFailWith error: Error?) {
        
        print(error)
        
    }

}

extension LoginViewController: GIDSignInUIDelegate {
    

    
}


