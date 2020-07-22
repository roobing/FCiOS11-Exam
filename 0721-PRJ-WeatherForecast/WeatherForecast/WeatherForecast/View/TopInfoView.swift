//
//  TopInfoView.swift
//  WeatherForecast
//
//  Created by Woobin Cheon on 2020/07/22.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class TopInfoView: UIView {
    
    let locationLabel = UILabel()
    let updateTimeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    func setupUI() {
        locationLabel.textAlignment = .center
        locationLabel.text = "수원시"
        locationLabel.font = UIFont.boldSystemFont(ofSize: 20)
        locationLabel.textColor = .white
        
        updateTimeLabel.textAlignment = .center
        updateTimeLabel.text = "오후 12:14"
        updateTimeLabel.font = UIFont.systemFont(ofSize: 15)
        updateTimeLabel.textColor = .white
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        [locationLabel, updateTimeLabel].forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            
//            switch $0 {
//            case locationLabel:
//                $0.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//                $0.bottomAnchor.constraint(equalTo: updateTimeLabel.topAnchor).isActive = true
//            case updateTimeLabel:
//                $0.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//            default:
//                break
//            }
        })
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: self.topAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: updateTimeLabel.topAnchor),
            
            updateTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
