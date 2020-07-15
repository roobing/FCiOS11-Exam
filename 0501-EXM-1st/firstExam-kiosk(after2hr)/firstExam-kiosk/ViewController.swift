//
//  ViewController.swift
//  firstExam-kiosk
//
//  Created by Woobin Cheon on 2020/05/01.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // UILabel, UIButton 프로퍼티
    let myMoneyLabel: UILabel = UILabel()
    let toPayLabel: UILabel = UILabel()
    let myMoneyDisLabel: UILabel = UILabel()
    let toPayDisLabel: UILabel = UILabel()
    let resetButton: UIButton = UIButton(type: .system)
    let payButton: UIButton = UIButton(type: .system)
    
    // IBOutlet 프로퍼티
    @IBOutlet weak var 짜장면수량라벨: UILabel!
    @IBOutlet weak var 짬뽕수량라벨: UILabel!
    @IBOutlet weak var 탕수육수량라벨: UILabel!
    
    // 변수 프로퍼티
    var 짜장면count: Int  = 0
    var 짬뽕count: Int  = 0
    var 탕수육count: Int  = 0
    
    // 프로퍼티 옵저버
    var myMoney: Int = 70000 {
        didSet {
            myMoneyDisLabel.text = "\(myMoney)원"
        }
    }
    var toPayValue: Int = 0{ // content의 데이터가 바뀌면 아래 didSet이 실행됨
        didSet {
            toPayDisLabel.text = "\(toPayValue)원"
        }
    }
    
    // view life cycle 메소드
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        drawUI()
    }
    
    // IBAction func 메소드
    @IBAction func 짜장면버튼(_ sender: UIButton) {
        짜장면count += 1
        짜장면수량라벨.text = String(짜장면count)
        toPayValue = 짜장면count * 5000 + 짬뽕count * 6000 + 탕수육count * 12000
    }
    @IBAction func 짬뽕버튼(_ sender: UIButton) {
        짬뽕count += 1
        짬뽕수량라벨.text = String(짬뽕count)
        toPayValue = 짜장면count * 5000 + 짬뽕count * 6000 + 탕수육count * 12000
    }
    @IBAction func 탕수육버튼(_ sender: UIButton) {
        탕수육count += 1
        탕수육수량라벨.text = String(탕수육count)
        toPayValue = 짜장면count * 5000 + 짬뽕count * 6000 + 탕수육count * 12000
    }
    
    // objc 메소드
    @objc func resetAction(_ sender: UIButton) {
        짜장면count = 0
        짬뽕count = 0
        탕수육count = 0
        짜장면수량라벨.text = "0"
        짬뽕수량라벨.text = "0"
        탕수육수량라벨.text = "0"
        toPayValue = 0
        myMoney = 70000
    }
    
    @objc func payAction(_ sender: UIButton) {
        //Pay Confirm Pop-Up
        if toPayValue > self.myMoney {
            let alertViewContorller = UIAlertController(title: "소지금액이 부족합니다.", message: "상품을 다시 담아주세요.", preferredStyle: .alert)
            let alertPayAction = UIAlertAction(title: "확인", style: .default) {_ in
               self.짜장면count = 0
               self.짬뽕count = 0
               self.탕수육count = 0
               self.짜장면수량라벨.text = "0"
               self.짬뽕수량라벨.text = "0"
               self.탕수육수량라벨.text = "0"
               self.toPayValue = 0
            }
            alertViewContorller.addAction(alertPayAction)
            
            self.present(alertViewContorller, animated: true, completion: nil)
        }
        else if toPayValue == self.myMoney {
            let alertViewContorller = UIAlertController(title: "소지금액을 모두 쓰시겠습니까?", message: "총 결제 금액은 \(toPayValue)원 입니다.", preferredStyle: .alert)
            let alertPayAction = UIAlertAction(title: "확인", style: .destructive) {_ in
                self.myMoney = self.myMoney - self.toPayValue
                self.짜장면count = 0
                self.짬뽕count = 0
                self.탕수육count = 0
                self.짜장면수량라벨.text = "0"
                self.짬뽕수량라벨.text = "0"
                self.탕수육수량라벨.text = "0"
                self.toPayValue = 0
            }
            let alertCancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alertViewContorller.addAction(alertPayAction)
            alertViewContorller.addAction(alertCancelAction)
            
            self.present(alertViewContorller, animated: true, completion: nil)
        }
        else {
            let alertViewContorller = UIAlertController(title: "결제하시겠습니까?", message: "총 결제 금액은 \(toPayValue)원 입니다.", preferredStyle: .alert)
            let alertPayAction = UIAlertAction(title: "확인", style: .destructive) {_ in
                self.myMoney = self.myMoney - self.toPayValue
                self.짜장면count = 0
                self.짬뽕count = 0
                self.탕수육count = 0
                self.짜장면수량라벨.text = "0"
                self.짬뽕수량라벨.text = "0"
                self.탕수육수량라벨.text = "0"
                self.toPayValue = 0
            }
            let alertCancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alertViewContorller.addAction(alertPayAction)
            alertViewContorller.addAction(alertCancelAction)
            
            self.present(alertViewContorller, animated: true, completion: nil)
        }
    }
    
    // Custom UI 메소드
    private func drawUI() {
        
        myMoneyLabel.frame = CGRect(x: 20, y: 350, width: 80, height: 40)
        myMoneyLabel.backgroundColor = .systemGreen
        myMoneyLabel.text = "소지금"
        myMoneyLabel.textAlignment = NSTextAlignment.center
        view.addSubview(myMoneyLabel)
        
        toPayLabel.frame = CGRect(x: 20, y: 400, width: 80, height: 40)
        toPayLabel.backgroundColor = .systemOrange
        toPayLabel.text = "결제금액"
        toPayLabel.textAlignment = NSTextAlignment.center
        view.addSubview(toPayLabel)
        
        myMoneyDisLabel.frame = CGRect(x: 110, y: 350, width: 140, height: 40)
        myMoneyDisLabel.backgroundColor = .systemGreen
        myMoneyDisLabel.text = "\(myMoney)원"
        myMoneyDisLabel.textAlignment = NSTextAlignment.right
        view.addSubview(myMoneyDisLabel)
        
        toPayDisLabel.frame = CGRect(x: 110, y: 400, width: 140, height: 40)
        toPayDisLabel.backgroundColor = .systemOrange
        toPayDisLabel.text = "\(toPayValue)원"
        toPayDisLabel.textAlignment = NSTextAlignment.right
        view.addSubview(toPayDisLabel)
        
        resetButton.frame = CGRect(x: 270, y: 350, width: 80, height: 40)
        resetButton.backgroundColor = .black
        resetButton.setTitle("초기화", for: .normal)
        resetButton.addTarget(self, action: #selector(resetAction(_:)), for: .touchUpInside)
        view.addSubview(resetButton)
        
        payButton.frame = CGRect(x: 270, y: 400, width: 80, height: 40)
        payButton.backgroundColor = .black
        payButton.setTitle("결제", for: .normal)
        payButton.addTarget(self, action: #selector(payAction(_:)), for: .touchUpInside)
        view.addSubview(payButton)
        
    }


}

