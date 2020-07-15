//
//  AppDelegate.swift
//  firstExam-kiosk
//
//  Created by Woobin Cheon on 2020/05/01.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//
/*
 UI구현: 완료
 주문하기 기능: 완료
 결제하기 기능: 완료 (소지금액과 결제금액 비교 로직은 결제버튼 objc 메소드에 구현)
 초기화 기능: 완료
 AlertControl 동작: 완료(소지금액과 결제금액이 같은 경우의 AlertController 추가)
 */
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

