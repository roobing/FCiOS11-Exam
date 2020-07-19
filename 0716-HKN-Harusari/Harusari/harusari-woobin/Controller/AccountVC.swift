//
//  AccountViewController.swift
//  harusari-woobin
//
//  Created by Woobin Cheon on 2020/07/16.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {

    let accountView = AccountView()
    
    var testDataList = [SpendingData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountView.delegate = self
        setupUI()
        setupConstraint()
        // test data for previous date
        for _ in 1...3 {
            testDataList.append( SpendingData(spendingCategoryImage: "bolt", spendingMoney: 1000, spendingDetail: "테스트 데이터"))
        }
       
        spendingDataInfo.updateValue(testDataList, forKey: "2020. 7. 18.")
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if spendingDataList.isEmpty {
            // do nothing
        } else {
            let index = spendingDataList.count - 1
            totalMoney = totalMoney - spendingDataList[index].spendingMoney
            print("totlaMoney: \(totalMoney), at \(#function)")
            accountView.setupUI(with: totalMoney)
            accountView.itemListTabelView.reloadData()
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    func setupConstraint() {
        view.addSubview(accountView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        accountView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            accountView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            accountView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            accountView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            accountView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
extension AccountVC: PresentDelegate {
    
    func presentView() {
        let vc = AddAccountVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
