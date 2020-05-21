//
//  ViewController.swift
//  CalculatorExample
//
//  Created by giftbot on 2019/12/19.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

var newNum: Double?
var prevNum: Double?
var newOperKey: String?
var prevOperKey: String?
var makeMinusFlag: Bool = false
var numInputCount: Int  = 0
var number = 1
final class ViewController: UIViewController {

    let formatter = NumberFormatter()
    
    @IBOutlet var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        formatter.numberStyle = .decimal    // 천 단위로 콤마(,)
        formatter.minimumFractionDigits = 0    // 최소 소수점 단위
        formatter.maximumFractionDigits = 3    // 최대 소수점 단위
    }
    
    @IBAction func numKeys(_ sender: UIButton) {
        
        numInputCount += 1
        
        if numInputCount <= 13 {
            newNum = (newNum ?? 0) * 10 + (Double(sender.currentTitle ?? "0") ?? 0)
            if newNum != nil && makeMinusFlag == false {
                if prevOperKey != "=" {
//                    setDisplay(by: String(newNum!))
                    displayLabel.text = formatter.string(from: newNum! as NSNumber)
                }
                else {
                    prevNum = nil
                    setDisplay(by: String(newNum!))
                }
            }
            else if newNum != nil && makeMinusFlag == true {
                makeMinusFlag = false
                newNum = (-newNum!)
                setDisplay(by: String(newNum!))
            }
            else if newNum == nil {
                setDisplay(by: "nil")
            }
            displayLabel.text = formatter.string(from: newNum! as NSNumber)
        }
        else {
            // do nothing
        }
    }

    @IBAction func operationKeys(_ sender: UIButton) {

        guard let inputOper = sender.currentTitle else { return }
        newOperKey = inputOper
        
        numInputCount = 0
        
        if prevNum == nil && newNum == nil {
            if newOperKey == "-" {
                makeMinusFlag = true
            }
            else {
                // do nothing
            }
        }
        else if prevNum == nil && newNum != nil {
            prevNum = newNum
            newNum = nil
//            setDisplay(by: String(prevNum!))
            displayLabel.text = formatter.string(from: prevNum! as NSNumber)
            if newOperKey != "=" {
                prevOperKey = newOperKey
            }
            else {
                newNum = nil
                prevNum = nil
                prevOperKey = nil
                newOperKey = nil
            }
        }
        else if prevNum != nil && newNum == nil {
            if newOperKey == "=" {
                newNum = prevNum
                prevNum = prevCalExe(prevNum, newNum, prevOperKey)
                displayLabel.text = formatter.string(from: prevNum! as NSNumber)
//                setDisplay(by: String(prevNum!))
                newNum = nil
                prevOperKey = newOperKey
            }
            else {
                prevOperKey = newOperKey
            }
        }
        else if prevNum != nil && newNum != nil {
            prevNum = prevCalExe(prevNum, newNum, prevOperKey)
//            setDisplay(by: String(prevNum!))
            displayLabel.text = formatter.string(from: prevNum! as NSNumber)
            newNum = nil
            prevOperKey = newOperKey
        }
    }
    
    @IBAction func acKey(_ sender: UIButton) {
        initCal()
    }
    
    func initCal() {
        newNum = nil
        prevNum = nil
        numInputCount = 0
        makeMinusFlag = false
        newOperKey = nil
        prevOperKey = nil
        setDisplay(by: "0")
    }
    
    func setDisplay(by num: String) {
        displayLabel.text = num
    }
    
    func prevCalExe(_ prevNum: Double?, _ newNum: Double?, _ prevOper: String?) -> Double {
        switch prevOper! {
        case "+":
            return prevNum! + newNum!
        case "-":
            return prevNum! - newNum!
        case "×":
            return prevNum! * newNum!
        case "÷":
            if newNum != 0 {
                return prevNum! / newNum!
            }
            else {
                return 0
            }
        case "=":
            return prevNum!
        default:
            return 0
        }
    }
}
