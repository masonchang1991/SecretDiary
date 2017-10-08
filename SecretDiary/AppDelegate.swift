//
//  AppDelegate.swift
//  SecretDiary
//
//  Created by Ｍason Chang on 2017/10/7.
//  Copyright © 2017年 Ｍason Chang. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var googleLoginViewController: UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

        return true
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(
                    application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        
        return handled
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        // record users' counts
        FBSDKAppEvents.activateApp()
        
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    

}

extension AppDelegate: GIDSignInDelegate {

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if error != nil {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        
        let firebaseLoginClient = FirebaseLoginClient(googleIdTokenString: authentication.idToken,
                                                           googleAccessTokenString: authentication.accessToken,
                                                           loginViewController: googleLoginViewController)
        
        firebaseLoginClient.login()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

}

