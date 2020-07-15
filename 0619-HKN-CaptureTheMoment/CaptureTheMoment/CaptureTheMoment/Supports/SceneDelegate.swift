//
//  SceneDelegate.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/20/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let rootViewController = HomeController(persistenceManager: PersistenceManager.shared)
        let navigationRootViewController = UINavigationController(rootViewController: rootViewController)
        navigationRootViewController.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationRootViewController.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationRootViewController.navigationBar.shadowImage = UIImage()
        navigationRootViewController.navigationBar.barStyle = .black
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationRootViewController
//        window?.rootViewController = RegisterController(persistenceManager: PersistenceManager.shared)
        window?.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}

