//
//  AppDelegate.swift
//  1st-hackathon-movie
//
//  Created by Woobin Cheon on 2020/06/03.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        return true
    }
}

