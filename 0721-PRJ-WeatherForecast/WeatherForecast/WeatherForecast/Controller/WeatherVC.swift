//
//  WeatherVC.swift
//  WeatherForecast
//
//  Created by Woobin Cheon on 2020/07/22.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {
    
    let backImage = UIImageView()
    let reloadButton = UIBarButtonItem()
    let topInfoView = TopInfoView()
    let scrolledInfoView = ScrolledInfoView()
    let backScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraint()

    }
    
    func setupUI() {
        backImage.image = UIImage(named: "sunny")
        
        navigationItem.titleView = topInfoView
        
        let reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(weatherInfoReload(_:)))
        navigationItem.rightBarButtonItem = reloadButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
    }
    
    func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        [backImage, backScrollView].forEach({
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        backScrollView.addSubview(scrolledInfoView)
        scrolledInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backImage.topAnchor.constraint(equalTo: view.topAnchor),
            backImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backScrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            backScrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            backScrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            backScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrolledInfoView.topAnchor.constraint(equalTo: backScrollView.contentLayoutGuide.topAnchor),
            scrolledInfoView.leadingAnchor.constraint(equalTo: backScrollView.contentLayoutGuide.leadingAnchor),
            scrolledInfoView.trailingAnchor.constraint(equalTo: backScrollView.contentLayoutGuide.trailingAnchor),
            scrolledInfoView.bottomAnchor.constraint(equalTo: backScrollView.contentLayoutGuide.bottomAnchor),
            scrolledInfoView.widthAnchor.constraint(equalTo: backScrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    // MARK: - Selector
    @objc func weatherInfoReload(_ sender: UIBarButtonItem) {
        print("Weahter Info Reload...")
    }
    
}
