//
//  SignUpVC.swift
//  Harusali
//
//  Created by 김믿음 on 2020/07/14.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class SignUpVC: UIViewController {
    
    // MARK: Property
    let firestore = Firestore.firestore()
    
    let backgroundImage: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "whiteBackground")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let balance : String = "0"
    var checkSetBalance : Bool = UserDefaults.standard.bool(forKey: UserReference.checkSetBalance)
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "회원 가입"
        label.font = UIFont(name: "BMEULJIRO", size: 60)
        label.textColor = UIColor(rgb: 0x017831)
        return label
    }()
    
    let nameTextField : UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = "name"
        nameTextField.borderStyle = .roundedRect
        return nameTextField
    }()
    
    let emailTextField : UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = "email"
        emailTextField.borderStyle = .roundedRect
        return emailTextField
    }()
    
    let passWordTextField : UITextField = {
        let passWordTextField = UITextField()
        passWordTextField.placeholder = "password"
        passWordTextField.isSecureTextEntry = true
        passWordTextField.borderStyle = .roundedRect
        return passWordTextField
    }()
    
    let signUpBT : UIButton = {
        let signUpBT = UIButton()
        signUpBT.setTitle("SignUp", for: .normal)
        signUpBT.titleLabel!.font = UIFont(name: "BMEULJIRO", size: 20)
        signUpBT.layer.cornerRadius = 10
        signUpBT.backgroundColor = .systemGray
        signUpBT.backgroundColor = UIColor(rgb: 0x12b71a)
        signUpBT.addTarget(self, action: #selector(signUpBtTap), for: .touchUpInside)
        return signUpBT
    }()
    
    let backButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.turn.up.left"), for: .normal)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        button.tintColor = UIColor(rgb: 0x12b71a)
        return button
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(rgb: 0xc4e8bf)
        title = "회원가입"
        
        setUpConstraints()
    }
    
    // MARK: KeyBoard UP
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // MARK: @Objc
    @objc func signUpBtTap(_ sender : UIButton){
        guard let email = emailTextField.text, let password = passWordTextField.text
            , let name = nameTextField.text else {return}
        signUp(email: email,password: password, name: name, balance: balance, checkSetBalance: checkSetBalance) { (result) in
            switch result {
            case .failure:
                self.failureSignUpAlert()
            case .success:
                self.successSignUpAlert()
            }
        }
    }
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: SignUP Func
    private func signUp(email: String, password: String, name: String, balance: String, checkSetBalance: Bool, completion: @escaping (Result<String,Error>) -> ()) {
        
        guard let email = self.emailTextField.text else {return}
        guard let password = self.passWordTextField.text else {return}
        
        
        Auth.auth().createUser(withEmail: email, password: password) {( result, error) in
            if let error = error {
                print("Fail SignUp")
                completion(.failure(error))
            } else {
                print("Sucess SignUp")
                guard let user = result?.user else {return}
                self
                    .firestore
                    .collection("User")
                    .document(user.uid)
                    .setData([
                        UserReference.email : email,
                        UserReference.name : name,
                        UserReference.balance : balance,
                        UserReference.checkSetBalance : checkSetBalance
                    ]) {(error) in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success("Success"))
                        }
                }
                self.checkSetBalance = false
                UserDefaults.standard.set(self.checkSetBalance, forKey: UserReference.checkSetBalance)
                print("회원가입하고 현재 checkSetBalance 는 \(UserDefaults.standard.bool(forKey: UserReference.checkSetBalance))")
            }
        }
        
        
    }
    
    
    // MARK: SignUp Alert Func
    private func successSignUpAlert(title: String? = nil, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "알림", message: "회원가입 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .destructive) { (action) in self.backToLogin()}
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert,animated: false,completion: nil)
    }
    
    private func failureSignUpAlert(title: String? = nil, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "알림", message: "다시 입력해주세요!", preferredStyle: UIAlertController.Style.alert)
//        alert.setValue(NSAttributedString(string: <#T##String#>, attributes: <#T##[NSAttributedString.Key : Any]?#>))
        let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        present(alert,animated: false,completion: nil)
    }

//    alert.setValue(NSAttributedString(string: messageTitle, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(17),NSForegroundColorAttributeName : UIColor.redColor()]), forKey: "attributedTitle")

    
    private func backToLogin(){
        self.navigationController?.popViewController(animated: true)
        print("popview 하는중에 현재 checkSetBalance\(UserDefaults.standard.bool(forKey: UserReference.checkSetBalance))")
    }
    
    // MARK: SetUpConstraints
    private func setUpConstraints() {
        [backgroundImage, titleLabel, backButton, nameTextField, passWordTextField, emailTextField, signUpBT].forEach {
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
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passWordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passWordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            passWordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signUpBT.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor, constant: 50),
            signUpBT.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            signUpBT.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
