//
//  FBLoginDelegate.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/7.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import Foundation

protocol FBLoginDelegate:class {
    
    func fbLoginManager(manager: LoginClient, didGet tokenString: String, userData: [String: String])
    
    func fbLoginManager(manager: LoginClient, didFailWith error: Error?)
    
}
