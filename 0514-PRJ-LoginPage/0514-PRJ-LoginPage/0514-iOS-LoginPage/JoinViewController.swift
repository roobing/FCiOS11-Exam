//
//  JoinViewController.swift
//  0514-iOS-LoginPage
//
//  Created by Woobin Cheon on 2020/05/14.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var newEmailTextField: UITextField!
    @IBOutlet weak var newPwTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newEmailTextField.delegate = self
        newPwTextField.delegate = self

    }
    @IBAction func cancelJoinButton(_ sender: UIButton) {
        guard let vc = presentingViewController as? ViewController else {return}
        vc.dismiss(animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    @IBAction func joinButton(_ sender: UIButton) {
        guard let vc = presentingViewController as? ViewController else {return}
        vc.userIDData = newEmailTextField.text ?? "no input"
        vc.userPWData = newPwTextField.text ?? "no input"
        vc.emailTextField.text = ""
        vc.pwTextField.text = ""
        vc.dismiss(animated: true)
    }
    
}
