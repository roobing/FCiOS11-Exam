//
//  mainViewController.swift
//  0514-iOS-LoginPage
//
//  Created by Woobin Cheon on 2020/05/14.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {

    @IBOutlet weak var userIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIDLabel.text = UserDefaults.standard.string(forKey: UserInfo.loginID)
        print(userIDLabel.text)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 스토리보드로 생성한 메인뷰에 데이터 전달 어떻게 함??? 루트뷰에서 참조가 안되는데??
        guard let vc = presentingViewController as? ViewController else {return}
//        userIDLabel.text = vc.emailTextField.text
    }
    @IBAction func signOutButton(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: UserInfo.loginID)
        
        if let _ = presentingViewController as? ViewController {
            guard let vc = presentingViewController as? ViewController else { return }
            vc.emailTextField.text = ""
            vc.pwTextField.text = ""
            vc.dismiss(animated: true)
        } else { // 로그아웃시, 원래 처음 화면으로 앤트리포인트 잡는 부분
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "ViewController")
                viewController.modalPresentationStyle = .fullScreen
                window.rootViewController = viewController
                
                let sceneDelegate = windowScene.delegate as? SceneDelegate
                sceneDelegate?.window = window
                window.makeKeyAndVisible()
                // end
            }
        }
    }
}

/*
 if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
     let window = UIWindow(windowScene: windowScene)
     let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
     let rootViewController = mainStoryboard.instantiateInitialViewController() as! ViewController
     rootViewController.view.backgroundColor = .systemBackground
     window.rootViewController = rootViewController

     let sceneDelegate = windowScene.delegate as? SceneDelegate
     sceneDelegate?.window = window
     window.makeKeyAndVisible()
 }
 */
