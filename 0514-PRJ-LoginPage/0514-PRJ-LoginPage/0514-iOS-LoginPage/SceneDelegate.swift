//
//  SceneDelegate.swift
//  0514-iOS-LoginPage
//
//  Created by Woobin Cheon on 2020/05/14.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    //    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
    //      let sceneDelegate = windowScene.delegate as? SceneDelegate
    //      sceneDelegate?.window?.rootViewController = SignInViewController()
    //    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // 로그인 성공한 경우, 앱 종료 후 재시작 시 로그인된 메인화면을 앤트리 포인트로 설정하는 부분
        // 유저 디폴트 인스턴스(sceneUserDefaults)를 생성해서 기존에 저장된 값이 있는지 확인해서
        // 있으면 메인화면을 엔트리 포인트로 설정하고 아니면 do nothing
        let sceneUserDefaults = UserDefaults.standard
        if sceneUserDefaults.string(forKey: UserInfo.loginID) != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainView = storyboard.instantiateViewController(identifier: "mainView")
            mainView.modalPresentationStyle = .fullScreen
            self.window?.rootViewController = mainView
        }
        // end
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

