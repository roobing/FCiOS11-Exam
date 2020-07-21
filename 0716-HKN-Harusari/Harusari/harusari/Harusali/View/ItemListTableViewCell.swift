//
//  ItemListTableViewCell.swift
//  harusari-woobin
//
//  Created by Woobin Cheon on 2020/07/17.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {
    
    let backgroundImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "whiteBackground")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.2
        return imageView
    }()
    
    static let idendifier = "ItemListTableViewCell"
    
    let categoryImage = UIImageView()
    let moneyLabel = UILabel()
    let detailLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI(UIImage(systemName: "xmark.square")!, 0, "내용 없음")
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    func setupUI(with date: String, index indexRow: Int) {
        
        let tempList = spendingDataInfo[date] ?? [SpendingData]()
//        categoryImage.backgroundColor = .systemGreen
        categoryImage.image = UIImage(named: tempList[indexRow].spendingCategoryImage)
        categoryImage.contentMode = .scaleAspectFit
        
//        moneyLabel.backgroundColor = .systemGreen
        
        moneyLabel.font = UIFont(name: "BMEULJIRO", size: 20)
        moneyLabel.text = "₩ \(tempList[indexRow].spendingMoney)"
        
//        detailLabel.backgroundColor = .systemGreen
        detailLabel.font = UIFont(name: "BMEULJIRO", size: 15)
        detailLabel.text = tempList[indexRow].spendingDetail
        
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        [backgroundImage, categoryImage, moneyLabel, detailLabel].forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            categoryImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            categoryImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            categoryImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            categoryImage.widthAnchor.constraint(equalToConstant: 80),
            
            moneyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            moneyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            detailLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            detailLabel.leadingAnchor.constraint(equalTo: categoryImage.trailingAnchor, constant: 10),
        ])
    }
}
