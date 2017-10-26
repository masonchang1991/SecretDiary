//
//  FirebaseLoginDelegate.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/7.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import Foundation

protocol FirebaseLoginDelegate {
    
    func firebaseLogin(loginClient: FirebaseLoginClient, didSuccessWith loginType: LoginRouter)
    
    func firebaseLogin(loginClient: FirebaseLoginClient, didFailWith error: Error?)
    
}
