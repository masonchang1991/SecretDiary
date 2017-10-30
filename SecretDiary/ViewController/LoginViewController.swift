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
    
    deinit {
        print("LoginviewController gone")
    }
    
}

extension LoginViewController: FirebaseLoginDelegate {
    
    func firebaseLogin(loginClient: FirebaseLoginClient, didSuccessWith loginType: LoginRouter) {
        
        print(loginType)
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        guard let rootViewController = window.rootViewController else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabbar = storyboard.instantiateViewController(withIdentifier: "MainTabbar")
        mainTabbar.view.frame = rootViewController.view.frame
        mainTabbar.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = mainTabbar
        }, completion: { completed in
            // maybe do something here
            print("success change root view controller")
        })
        
    }
    
    func firebaseLogin(loginClient: FirebaseLoginClient, didFailWith error: Error?) {
        
        print(error)
        
    }

}

extension LoginViewController: GIDSignInUIDelegate {
    

    
}


