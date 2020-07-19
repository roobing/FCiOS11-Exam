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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAccountView.delegate = self
        setupUI()
        setupConstraint()

    }
    
    // MARK: - Setup UI
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        addAccountView.backgroundColor = .lightGray
        
        view.addSubview(addAccountView)
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        addAccountView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            addAccountView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            addAccountView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            addAccountView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            addAccountView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -260)
        ])
    }
}

extension AddAccountVC: AddAccountViewDelegate {
    func changeButtonBackground(_ sender: UIButton, _ flag: Bool) -> UIColor {
        if flag {
            return UIColor.systemRed
        } else {
            return UIColor.clear
        }
    }
    
    func dismissView() {
        guard let vc = presentingViewController as? AccountVC else {return}
        vc.dismiss(animated: true)
    }
    
    func spendingInfoTransfer(_ money: Int, _ category: String, _ memo: String) {
        let tempStruct = SpendingData(spendingCategoryImage: category, spendingMoney: money, spendingDetail: memo)
        spendingDataList.append(tempStruct)
        spendingDataInfo.updateValue(spendingDataList, forKey: todayDate)
    }
    
    func makeAlert() {
        let alertControl = UIAlertController(title: "경고", message: "잔액부족", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alertControl.addAction(confirmAction)
        present(alertControl, animated: true)
    }
}
