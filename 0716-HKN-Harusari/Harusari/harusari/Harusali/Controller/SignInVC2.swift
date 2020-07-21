//
//  LoginVC.swift
//  Harusali
//
//  Created by 김믿음 on 2020/07/12.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit
import Firebase

class SignInVC2: UIViewController {
    
    // MARK: Properties
    let firestore = Firestore.firestore()
    
    let backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "whiteBackground")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "하루 살이"
        label.font = UIFont(name: "BMEULJIRO", size: 60)
        label.textColor = UIColor(rgb: 0x017831)
        return label
    }()
    
    let idTextField : UITextField = {
        let idTextField = UITextField()
        idTextField.keyboardType = .emailAddress
        idTextField.borderStyle = .roundedRect
        idTextField.placeholder = "email"
        return idTextField
    }()
    
    let passWordTextField : UITextField = {
        let passWordTextField = UITextField()
        passWordTextField.borderStyle = .roundedRect
        passWordTextField.placeholder = "password"
        passWordTextField.isSecureTextEntry = true
        return passWordTextField
    }()
    
    let loginBT : UIButton = {
        let loginBT = UIButton()
        loginBT.backgroundColor = UIColor(rgb: 0x12b71a)
        loginBT.setTitle("Login", for: .normal)
        loginBT.titleLabel!.font = UIFont(name: "BMEULJIRO", size: 20)
        loginBT.layer.cornerRadius = 10
        loginBT.addTarget(self, action: #selector(tapLoginBT(_:)), for: .touchUpInside)
        return loginBT
    }()
    
    let signupBT : UIButton = {
        let signupBT = UIButton()
        signupBT.backgroundColor = UIColor(rgb: 0x12b71a)
        signupBT.layer.cornerRadius = 10
        signupBT.setTitle("SignUp", for: .normal)
        signupBT.titleLabel!.font = UIFont(name: "BMEULJIRO", size: 20)
        signupBT.addTarget(self, action: #selector(tapSignUpBT(_:)), for: .touchUpInside)
        return signupBT
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = UIColor(rgb: 0xc4e8bf)
        
        self.setupConstraints()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: KeyBoard Up
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // MARK: @Objc
    @objc func tapLoginBT(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: idTextField.text!, password: passWordTextField.text!) { (user, error) in
            if user != nil {
                print("login Success")
                
                guard let user = user?.user else {return}
                self.firestore
                    .collection("User")
                    .document(user.uid)
                    .getDocument { (snapshot, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        }else {
                            guard
                                let data = snapshot?.data(),
                                let email = data[UserReference.email] as? String,
                                let name = data[UserReference.name] as? String,
                                let balance = data[UserReference.balance] as? String
                                //                                let checkSetBalance = data[UserReference.checkSetBalance] as? Bool
                                else {return}
                            
                            UserDefaults.standard.set(email, forKey: UserReference.email)
                            UserDefaults.standard.set(name, forKey: UserReference.name)
                            UserDefaults.standard.set(balance, forKey: UserReference.balance)
                            //                            UserDefaults.standard.set(checkSetBalance, forKey: UserReference.checkSetBalance)
                            print("로그인 할때 현재 checkSetBalance 는 \(UserDefaults.standard.bool(forKey: UserReference.checkSetBalance))")
                            if UserDefaults.standard.bool(forKey: UserReference.checkSetBalance) == false {
                                print(UserDefaults.standard.bool(forKey: UserReference.checkSetBalance))
                                UserDefaults.standard.set(true, forKey: UserReference.checkSetBalance)
                                print("설정안되어있었음")
                                self.navigationController?.pushViewController(MainVC(), animated: true)
                            } else if UserDefaults.standard.bool(forKey: UserReference.checkSetBalance) == true {
                                print("설정되어있었음")
                                self.dismiss(animated: true, completion: nil)
                            }
                            
                        }
                }
            }
            else{
                print("login fail")
            }
            self.idTextField.text = ""
            self.passWordTextField.text = ""
        }
        
    }
    
    @objc func tapSignUpBT(_ sender: UIButton) {
        let signupVC = SignUpVC()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    
    // MARK: SetUpConstraints
    private func setupConstraints() {
        [backgroundImage, titleLabel, idTextField, passWordTextField, signupBT, loginBT].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            idTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            idTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            idTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passWordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 10),
            passWordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            passWordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginBT.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor, constant: 50),
            loginBT.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            loginBT.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signupBT.topAnchor.constraint(equalTo: loginBT.bottomAnchor, constant: 10),
            signupBT.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            signupBT.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}




