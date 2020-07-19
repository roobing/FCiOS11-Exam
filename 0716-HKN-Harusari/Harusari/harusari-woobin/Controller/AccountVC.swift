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
    let dateFormatter = DateFormatter()
    
    var prevSpendingDataCount = 0
    
    // test data for previous date
    var testDataList = [SpendingData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountView.delegate = self
        
        setupUI()
        setupConstraint()
        
        // <=== test data for previous date
        for _ in 1...3 {
            testDataList.append( SpendingData(spendingCategoryImage: "bolt", spendingMoney: 1000, spendingDetail: "테스트 데이터1"))
        }
        spendingDataInfo.updateValue(testDataList, forKey: "2020. 7. 18.")
        totalMoney.updateValue(1000, forKey: "2020. 7. 18.")
        testDataList.removeAll()
        for _ in 1...3 {
            testDataList.append( SpendingData(spendingCategoryImage: "flame", spendingMoney: 2000, spendingDetail: "테스트 데이터2"))
        }
        spendingDataInfo.updateValue(testDataList, forKey: "2020. 7. 19.")
        totalMoney.updateValue(5000, forKey: "2020. 7. 19.")
        // ===>
        
        sumMileage()
    }
    
    func sumMileage() {
        var totalMileage = 0
        for (_,value) in totalMoney {
            totalMileage += value
        }
        totalMileage = totalMileage - (totalMoney[selectedDate] ?? 0)
        mileage = totalMileage
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
extension AccountVC: AccountViewDelegate {
    
    func changeDate(to date: String) {
        selectedDate = date
    }
    
    func presentView() {
        let vc = AddAccountVC()
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true)
    }
}
