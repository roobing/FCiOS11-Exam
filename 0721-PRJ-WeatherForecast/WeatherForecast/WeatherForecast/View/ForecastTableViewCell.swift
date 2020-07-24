//
//  ForecastTableViewCell.swift
//  WeatherForecast
//
//  Created by Woobin Cheon on 2020/07/24.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    static let identifier = "ForecastCell"
    
    let dateLabel = UILabel()
    let timeLabel = UILabel()
    let iconImageView = UIImageView()
    let tempLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    func setupUI() {
        dateLabel.text = "5.29(Mon)"
        
        timeLabel.text = "12:00"
        
        iconImageView.image = UIImage(named: "01d")
        
        tempLabel.text = "29º"
        tempLabel.font = UIFont.systemFont(ofSize: 50)
        tempLabel.backgroundColor = .systemOrange
//        tempLabel.sizeToFit()
        
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        [dateLabel, timeLabel, iconImageView, tempLabel].forEach({
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.width * 0.5),
//            iconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            tempLabel.topAnchor.constraint(equalTo: self.topAnchor),
//            tempLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
