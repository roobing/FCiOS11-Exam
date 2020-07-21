//
//  AddAccountVC.swift
//  harusari-woobin
//
//  Created by Woobin Cheon on 2020/07/16.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class AddAccountVC: UIViewController {
    
    let addAccountView = AddAccountView()
    let backgroundImage: UIImageView = {
          let imageView = UIImageView()
           imageView.image = UIImage(named: "whiteBackground")
           imageView.contentMode = .scaleAspectFill
           imageView.alpha = 0.2
           return imageView
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAccountView.delegate = self
        setupUI()
        setupConstraint()

    }
    
    // MARK: - Setup UI
    func setupUI() {
        view.backgroundColor = UIColor(rgb: 0xc4e8bf) 
        
        addAccountView.backgroundColor = UIColor(rgb: 0xc4e8bf)
        
        view.addSubview(addAccountView)
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        addAccountView.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            addAccountView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            addAccountView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            addAccountView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            addAccountView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -260),
            
            
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}

extension AddAccountVC: AddAccountViewDelegate {
    
    
    
    
    func changeButtonBackground(_ sender: UIButton) -> UIColor {

        return UIColor.systemGreen
        
    }

    
    
    func dismissView() {
        guard let vc = presentingViewController as? AccountVC else {return}
        print("dismiss2")
        let numFormatter = NumberFormatter()
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 3
        numFormatter.numberStyle = .decimal
        vc.accountView.moneyValueLabel.text = "₩ \((numFormatter.string(from: NSNumber(value: totalMoney[selectedDate] ?? 0))) ?? "0")"
        vc.accountView.itemListTabelView.reloadData()
        vc.dismiss(animated: true)
    }
    
    func spendingInfoTransfer(_ category: String, _ money: Int, _ memo: String) {
        let tempStruct = SpendingData(spendingCategoryImage: category, spendingMoney: money, spendingDetail: memo)
        spendingDataList.append(tempStruct)
        spendingDataInfo.updateValue(spendingDataList, forKey: selectedDate)
    }
    
    func calculateTotalMoney(_ money: Int) {
        guard var temp = totalMoney[selectedDate] else { fatalError("calculate total money error")}
        temp = temp - money
        totalMoney.updateValue(temp, forKey: selectedDate)
    }
    
    func makeAlert(_ message: String) {
        let alertControl = UIAlertController(title: "경고", message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alertControl.addAction(confirmAction)
        present(alertControl, animated: true)
    }
}
