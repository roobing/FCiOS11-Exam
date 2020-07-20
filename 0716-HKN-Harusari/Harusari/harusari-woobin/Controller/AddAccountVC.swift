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
    let bottomBlock = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addAccountView.delegate = self
        setupUI()
        setupConstraint()

    }
    
    // MARK: - Setup UI
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        [addAccountView, bottomBlock].forEach({
            $0.backgroundColor = UIColor(rgb: 0xc4e8bf)
            self.view.addSubview($0)
        })
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        addAccountView.translatesAutoresizingMaskIntoConstraints = false
        bottomBlock.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            addAccountView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            addAccountView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            addAccountView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            addAccountView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -260), // -260
            
            bottomBlock.topAnchor.constraint(equalTo: addAccountView.bottomAnchor),
            bottomBlock.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            bottomBlock.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            bottomBlock.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension AddAccountVC: AddAccountViewDelegate {
    
    
    func changeButtonBackground(_ sender: UIButton, _ flag: Bool) -> UIColor {
        if flag {
            return UIColor.systemGreen
        } else {
            return UIColor.clear
        }
    }
    
    func dismissView() {
        guard let vc = presentingViewController as? AccountVC else {return}
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
