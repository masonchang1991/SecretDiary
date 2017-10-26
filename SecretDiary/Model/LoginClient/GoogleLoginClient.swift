//
//  GoogleLoginClient.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/7.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

class GoogleLoginClient: LoginClient {
    
    private(set) var loginViewController: GIDSignInUIDelegate?
    
    init(loginViewController: UIViewController) {
        
        guard let viewController = loginViewController as? GIDSignInUIDelegate else {
            return
        }
        
        self.loginViewController = viewController
        
    }
    
    func login() {
        
        GIDSignIn.sharedInstance().uiDelegate = self.loginViewController
        
        GIDSignIn.sharedInstance().signIn()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.googleLoginViewController = loginViewController as? UIViewController
        
        // TODO(developer) Configure the sign-in button look/feel
        
    }
    
    
    
    
}
