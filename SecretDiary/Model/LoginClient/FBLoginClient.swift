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
                
                print(error)
                
                self.delegate?.fbLoginManager(manager: self, didFailWith: error)
                
                return
            }
            
            if let tokenString = FBSDKAccessToken.current().tokenString {
                
                self.fetchProfile(tokenString: tokenString)
                
                
            }
        }
    }
    
    
    func fetchProfile(tokenString: String){
        
        print("attempt to fetch profile......")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {
            connection, result, error -> Void in
            
            if error != nil {
                print("登入失敗")
                print("longinerror =\(error)")
            } else {
                
                if let userData = result as? [String:Any]{
                    
                    print("成功登入")
                    
                    var userDic: [String: String] = [:]
                    
                    let email = userData["email"]  as! String
                    print(email)
                    userDic["email"] = email
                    
                    let firstName = userData["first_name"] as! String
                    print(firstName)
                    
                    let lastName = userData["last_name"] as! String
                    print(lastName)
                    userDic["name"] = lastName + " " + firstName
                    
                    if let picture = userData["picture"] as? NSDictionary,
                        let data = picture["data"] as? NSDictionary,
                        let url = data["url"] as? String {
                        print(url) //臉書大頭貼的url, 再放入imageView內秀出來
                        userDic["picURL"] = url
                    }

                    self.delegate?.fbLoginManager(manager: self,
                                                  didGet: tokenString,
                                                  userData: userDic)

                }
            }
        })
    }
}
