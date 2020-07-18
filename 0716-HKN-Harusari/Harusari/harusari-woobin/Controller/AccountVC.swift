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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountView.delegate = self
        setupUI()
        setupConstraint()
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
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
}
