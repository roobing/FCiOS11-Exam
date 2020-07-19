//
//  ItemListTableViewCell.swift
//  harusari-woobin
//
//  Created by Woobin Cheon on 2020/07/17.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {
    
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
        categoryImage.backgroundColor = .systemGreen
        categoryImage.image = UIImage(systemName: tempList[indexRow].spendingCategoryImage)
        categoryImage.contentMode = .scaleAspectFit
        
        moneyLabel.backgroundColor = .systemGreen
        moneyLabel.font = UIFont.systemFont(ofSize: 20)
        moneyLabel.text = "₩ \(tempList[indexRow].spendingMoney)"
        
        detailLabel.backgroundColor = .systemGreen
        detailLabel.text = tempList[indexRow].spendingDetail
        
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        [categoryImage, moneyLabel, detailLabel].forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        NSLayoutConstraint.activate([
            categoryImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            categoryImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            categoryImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            categoryImage.widthAnchor.constraint(equalToConstant: 80),
            
            moneyLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            moneyLabel.leadingAnchor.constraint(equalTo: categoryImage.trailingAnchor, constant: 10),
            moneyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            detailLabel.topAnchor.constraint(equalTo: moneyLabel.bottomAnchor, constant: 10),
            detailLabel.leadingAnchor.constraint(equalTo: categoryImage.trailingAnchor, constant: 10),
            detailLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            detailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
