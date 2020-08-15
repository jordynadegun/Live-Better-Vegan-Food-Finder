//
//  AppDelegate.swift
//  Live Better Final Project
//
//  Created by Jordyn Adegun on 7/24/20.
//  Copyright © 2020 Jordyn Adegun. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var vc: UIViewController!
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       FirebaseApp.configure()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.window = UIWindow(frame: UIScreen.main.bounds)
       // var vc: UIViewController!
        
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        if (UserDefaults.standard.value(forKey: "Sounds Good! Let's Eat!") as? String) == nil {
            //show subscription screen first time
            vc = storyboard.instantiateViewController(identifier: "SubscriptionPlanViewController")
        } else {
            //show the main screen
            vc = storyboard.instantiateInitialViewController()!
        }
        return true
    }
   
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

