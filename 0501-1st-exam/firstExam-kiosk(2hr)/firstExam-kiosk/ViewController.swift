//
//  ViewController.swift
//  firstExam-kiosk
//
//  Created by Woobin Cheon on 2020/05/01.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //        let bottomSection: UIView = UIView()
    let myMoneyLabel: UILabel = UILabel()
    let toPayLabel: UILabel = UILabel()
    let myMoneyDisLabel: UILabel = UILabel()
    let toPayDisLabel: UILabel = UILabel()
    let resetButton: UIButton = UIButton(type: .system)
    let payButton: UIButton = UIButton(type: .system)
    
    @IBOutlet weak var 짜장면수량라벨: UILabel!
    @IBOutlet weak var 짬뽕수량라벨: UILabel!
    @IBOutlet weak var 탕수육수량라벨: UILabel!
    
    //저장프로퍼티
    var 짜장면count: Int  = 0
    var 짬뽕count: Int  = 0
    var 탕수육count: Int  = 0
    var myMoney: Int = 70000
    var toPayValue: Int = 0
//    var toPayValue: Int {
//        get {
//
//        }
//        set {
//            toPayDisLabel.text = "\(newValue)원"
//        }
//
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        drawUI()
    }
    
    func alertReset() {
        myMoneyDisLabel.text = "\(myMoney - toPayValue)원"
        짜장면count = 0
        짬뽕count = 0
        탕수육count = 0
        짜장면수량라벨.text = "0"
        짬뽕수량라벨.text = "0"
        탕수육수량라벨.text = "0"
        toPayValue = 0
        toPayDisLabel.text = "\(toPayValue)원"
    }
    
    @IBAction func 짜장면버튼(_ sender: UIButton) {
        짜장면count += 1
        짜장면수량라벨.text = String(짜장면count)
        toPayValue = 짜장면count * 5000 + 짬뽕count * 6000 + 탕수육count * 12000
        toPayDisLabel.text = "\(toPayValue)원"
    }
    @IBAction func 짬뽕버튼(_ sender: UIButton) {
        짬뽕count += 1
        짬뽕수량라벨.text = String(짬뽕count)
        toPayValue = 짜장면count * 5000 + 짬뽕count * 6000 + 탕수육count * 12000
        toPayDisLabel.text = "\(toPayValue)원"
    }
    @IBAction func 탕수육버튼(_ sender: UIButton) {
        탕수육count += 1
        탕수육수량라벨.text = String(탕수육count)
        toPayValue = 짜장면count * 5000 + 짬뽕count * 6000 + 탕수육count * 12000
        toPayDisLabel.text = "\(toPayValue)원"
    }
    
    @objc func resetAction(_ sender: UIButton) {
        짜장면count = 0
        짬뽕count = 0
        탕수육count = 0
        짜장면수량라벨.text = "0"
        짬뽕수량라벨.text = "0"
        탕수육수량라벨.text = "0"
        toPayValue = 0
        myMoneyDisLabel.text = "\(myMoney)원"
        toPayDisLabel.text = "\(toPayValue)원"
    }
    
    @objc func payAction(_ sender: UIButton) {
        //alert pop up
        if toPayValue > 70000 {
            let alertViewContorller = UIAlertController(title: "한도금액초과", message: "상품을 다시 담아주세요.", preferredStyle: .alert)
            let alertPayAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            let alertCancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alertViewContorller.addAction(alertPayAction)
            alertViewContorller.addAction(alertCancelAction)
            
            self.present(alertViewContorller, animated: true, completion: nil)
        }
        else {
            let alertViewContorller = UIAlertController(title: "결제창", message: "결제하시겠습니까?", preferredStyle: .alert)
            let alertPayAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            let alertCancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alertViewContorller.addAction(alertPayAction)
            alertViewContorller.addAction(alertCancelAction)
            
            self.present(alertViewContorller, animated: true, completion: alertReset)
        }
    }
    
    private func drawUI() {
//        view.addSubview(bottomSection)
        
        myMoneyLabel.frame = CGRect(x: 20, y: 350, width: 80, height: 40)
        myMoneyLabel.backgroundColor = .systemGreen
        myMoneyLabel.text = "소지금"
        myMoneyLabel.textAlignment = NSTextAlignment.center
        view.addSubview(myMoneyLabel)
//        bottomSection.addSubview(myMoneyLabel)
        
        toPayLabel.frame = CGRect(x: 20, y: 400, width: 80, height: 40)
        toPayLabel.backgroundColor = .systemOrange
        toPayLabel.text = "결제금액"
        toPayLabel.textAlignment = NSTextAlignment.center
        view.addSubview(toPayLabel)
//        bottomSection.addSubview(toPayLabel)
        
        myMoneyDisLabel.frame = CGRect(x: 110, y: 350, width: 140, height: 40)
        myMoneyDisLabel.backgroundColor = .systemGreen
        myMoneyDisLabel.text = "\(myMoney - toPayValue)원"
        myMoneyDisLabel.textAlignment = NSTextAlignment.right
        view.addSubview(myMoneyDisLabel)
//        bottomSection.addSubview(myMoneyDisLabel)
        
        toPayDisLabel.frame = CGRect(x: 110, y: 400, width: 140, height: 40)
        toPayDisLabel.backgroundColor = .systemOrange
        toPayDisLabel.text = "\(toPayValue)원"
        toPayDisLabel.textAlignment = NSTextAlignment.right
        view.addSubview(toPayDisLabel)
//        bottomSection.addSubview(toPayDisLabel)
        
        resetButton.frame = CGRect(x: 270, y: 350, width: 80, height: 40)
        resetButton.backgroundColor = .black
        resetButton.setTitle("초기화", for: .normal)
        resetButton.addTarget(self, action: #selector(resetAction(_:)), for: .touchUpInside)
        view.addSubview(resetButton)
//        bottomSection.addSubview(resetButton)
        
        payButton.frame = CGRect(x: 270, y: 400, width: 80, height: 40)
        payButton.backgroundColor = .black
        payButton.setTitle("결제", for: .normal)
        payButton.addTarget(self, action: #selector(payAction(_:)), for: .touchUpInside)
        view.addSubview(payButton)
//        bottomSection.addSubview(payButton)
        
    }


}

