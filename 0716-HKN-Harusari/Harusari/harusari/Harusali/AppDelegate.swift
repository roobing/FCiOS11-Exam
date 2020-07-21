//
//  AppDelegate.swift
//  Harusali
//
//  Created by 김믿음 on 2020/07/12.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
                window?.rootViewController = AccountVC()
//        window?.rootViewController = IntroViewController()
        
        window?.makeKeyAndVisible()
        return true
    }
    
    
    
}

