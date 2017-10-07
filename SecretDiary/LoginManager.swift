//
//  LoginManager.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/7.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import Foundation


class LoginManager {
    
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
    
    
    func fbLogin(){
        
        
    }
    
    func googleLogin(){
        
        
    }
    
    func emailLogin(){
        
        
        
    }
    
    
    
}
