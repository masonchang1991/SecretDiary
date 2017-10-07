//
//  ViewController.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/7.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FirebaseLoginDelegate {
    
    @IBOutlet weak var contentView: LoginView!
    
    weak var loginManager: LoginManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginManager = LoginManager(loginViewController: self)
        
        contentView.fbLoginButton.addTarget(self,
                                            action: #selector(fbLogin),
                                            for: .touchUpInside)
        
        contentView.googleLoginButton.addTarget(self,
                                                action: #selector(googleLogin),
                                                for: .touchUpInside)
       
        
    }
    
    @objc func fbLogin() {
        
        loginManager?.login(loginType: .facebook)
        
    }
    
    @objc func googleLogin() {
        
        loginManager?.googleLogin()
        
    }
    
    
    

    func firebaseLogin(loginClient: FirebaseLoginClient, didSuccessWith loginType: LoginRouter) {
        
        print(loginType)
        
    }
    
    func firebaseLogin(loginClient: FirebaseLoginClient, didFailWith error: Error?) {
        
        
    }


}


