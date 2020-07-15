//
//  ViewController.swift
//  0514-iOS-LoginPage
//
//  Created by Woobin Cheon on 2020/05/14.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

// 로그인 정보 저장을 위한 유저디폴트 정의. 전역변수로 쓰기위해 클래스 밖에 선언.
struct UserInfo {
    static let loginID : String = "loginID"
}
//end

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginSectionView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var 회원가입Button: UIButton!
    
    var test: UIView = UIView()
    var userIDData: String = "fast@campus.com"
    var userPWData: String = "gogogo"
    var userID: String = ""
    var userPW: String = ""
    var idOK: Bool = false
    var pwOK: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        pwTextField.delegate = self
        회원가입Button.alpha = 1
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text ?? "0").count >= 16 {
           return false
        }
        else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, animations: {() -> () in
            self.loginSectionView.frame.origin = CGPoint(x: 16, y: 200)
            self.회원가입Button.alpha = 0
        })
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, animations: {() -> () in
            self.loginSectionView.frame.origin = CGPoint(x: 16, y: 404)
//            self.회원가입Button.alpha = 1
        })
    }
    @IBAction func emailTextFieldTouchUpInside(_ sender: UITextField) {
        emailTextField.becomeFirstResponder()
    }
    @IBAction func pwTextFieldTouchUpInside(_ sender: UITextField) {
        pwTextField.becomeFirstResponder()
    }
    @IBAction func emailTextFieldEditingDidEnd(_ sender: UITextField) {
        emailTextField.resignFirstResponder()
    }
    @IBAction func pwTextFieldEditingDidEnd(_ sender: UITextField) {
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        pwTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {() -> () in
                    self.회원가입Button.alpha = 1
                })
        self.userID = emailTextField.text ?? "No input"
        self.userPW = pwTextField.text ?? "No input"
        if self.userID == userIDData {
            idOK = true
        }
        else {
            idOK = false
        }
        if self.userPW == userPWData {
            pwOK = true
        }
        else {
            pwOK = false
        }
        
        if idOK && pwOK {
            // 로그인 성공 시, 해당 이메일을 유저디폴트로 저장하는 부분
            let userDefaults = UserDefaults.standard
            userDefaults.set(self.emailTextField.text!, forKey: UserInfo.loginID)
            // end
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainView = storyboard.instantiateViewController(identifier: "mainView")
            mainView.modalPresentationStyle = .fullScreen
            present(mainView, animated: true)
        }
        else if idOK == true && pwOK == false {
            pwTextField.backgroundColor = .systemRed
            UIView.animate(withDuration: 1, animations: {() -> () in
                self.pwTextField.backgroundColor = .white
            })
            print("wrong pw")
        }
        else if idOK == false && pwOK == true{
            emailTextField.backgroundColor = .systemRed
            UIView.animate(withDuration: 1, animations: {() -> () in
                self.emailTextField.backgroundColor = .white
            })
            print("wrong id")
        }
        else {
            pwTextField.backgroundColor = .systemRed
            emailTextField.backgroundColor = .systemRed
            UIView.animate(withDuration: 1, animations: {() -> () in
                self.pwTextField.backgroundColor = .white
                self.emailTextField.backgroundColor = .white
            })
            print("wrong id & pw")
        }
        
        if userID.count < 4 || userPW.count < 4 {
            print("아이디와 비밀번호는 최소 4자리")
        }

        
    }
    @IBAction func 회원가입(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let joinVC = storyboard.instantiateViewController(identifier: "JoinView")
        present(joinVC, animated: true)
    }
}
