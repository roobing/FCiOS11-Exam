//
//  AccountViewController.swift
//  harusari-woobin
//
//  Created by Woobin Cheon on 2020/07/16.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit
import Lottie
import Firebase


class AccountVC: UIViewController {

    let signinVC1 = SignInVC1()
    lazy var navController1 = UINavigationController(rootViewController: self.signinVC1)
    let signinVC2 = SignInVC2()
    lazy var navController2 = UINavigationController(rootViewController: self.signinVC2)
    // 임시 로그아웃 버튼
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        return button
    }()
    lazy var animationView : AnimationView = {
        let animationView = AnimationView(name: "lf30_editor_alHpIE")
        animationView.frame = self.view.frame
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 0.5
        return animationView
    }()
    @objc func didTapLogout() {
        try? Auth.auth().signOut()
        UserDefaults.standard.set("", forKey: UserReference.name)
        UserDefaults.standard.set("", forKey: UserReference.email)
        print("logout")
        navController2.modalPresentationStyle = .fullScreen
        present(navController2, animated: true)
    }
    
    
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
        checkIfUserLoggedIn()
        
        
        sumMileage()
        
        genFakeData()
        
        animationView.play{ (finish) in
            self.animationView.removeFromSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        accountView.moneyValueLabel.text = "₩ \(UserDefaults.standard.string(forKey: UserReference.balance) ?? "0")"
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
        view.addSubview(logoutButton)
        view.addSubview(animationView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        accountView.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            accountView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            accountView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            accountView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            accountView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.leftAnchor.constraint(equalTo: view.leftAnchor),
            animationView.rightAnchor.constraint(equalTo: view.rightAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
    }
    // MARK: CheckCurrentUser And PresntViewController
    // 로그아웃 상태이면 로그인 창 프레젠트 된채로 (로그인 하면 mainVC 가 push)
    func checkIfUserLoggedIn() {
        if Auth.auth().currentUser == nil {
            print("-- SigninVC1 Did Load (Current Login State Is Logout State) --")
            DispatchQueue.main.async {
                self.navController1.modalPresentationStyle = .fullScreen
                self.present(self.navController1, animated: false)
            }
            return
        } else {
            print("-- SigninVC2 Did Load   (Current Login State Is Login State) --")
        }
    }
    
    func genFakeData() {
        // <=== test data for previous date
        testDataList.append( SpendingData(spendingCategoryImage: "fork", spendingMoney: 8000, spendingDetail: "점심"))
        testDataList.append( SpendingData(spendingCategoryImage: "gift", spendingMoney: 10000, spendingDetail: "선물"))
        testDataList.append( SpendingData(spendingCategoryImage: "beer", spendingMoney: 10000, spendingDetail: "저녁"))
        spendingDataInfo.updateValue(testDataList, forKey: "2020. 7. 19.")
        totalMoney.updateValue(3000, forKey: "2020. 7. 19.")
        testDataList.removeAll()

        testDataList.append( SpendingData(spendingCategoryImage: "fork", spendingMoney: 8000, spendingDetail: "아침"))
        testDataList.append( SpendingData(spendingCategoryImage: "transportation", spendingMoney: 1800, spendingDetail: "지하철"))
        testDataList.append( SpendingData(spendingCategoryImage: "ticket", spendingMoney: 10000, spendingDetail: "영화"))
        spendingDataInfo.updateValue(testDataList, forKey: "2020. 7. 20.")
        totalMoney.updateValue(2000, forKey: "2020. 7. 20.")
        // ===>
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

















