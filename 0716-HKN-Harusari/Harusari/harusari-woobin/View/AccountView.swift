//
//  AccountView.swift
//  harusari-woobin
//
//  Created by Woobin Cheon on 2020/07/16.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit
import FSCalendar

protocol PresentDelegate: class {
    func presentView()
}

class AccountView: UIView {
    
    let calendar = FSCalendar()
    var selectedDate = ""
    let dateFormatter = DateFormatter()
    var selectTodayFlag = false

    let dividerView1 = UIView()
    
    let moneyTitleLabel = UILabel()
    let moneyValueLabel = UILabel()
    let numFormatter = NumberFormatter()
    
    let dividerView2 = UIView()
    
    let itemListTabelView = UITableView()
    
    let addButton = UIButton()
    
    weak var delegate: PresentDelegate?
    
    struct addButtonSize {
        static let widthHeight: CGFloat = 70
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(#function)
        setupUI(with: totalMoney)
        setupConstraint()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Setup UI
    func setupUI(with totalMoney: Int) {
        calendar.dataSource = self
        calendar.delegate = self
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "ko-KR")
        todayDate = dateFormatter.string(from: calendar.selectedDate ?? Date())
        
        dividerView1.backgroundColor = .gray
        
        moneyTitleLabel.backgroundColor = .systemBlue
        moneyTitleLabel.font = UIFont.systemFont(ofSize: 35)
        moneyTitleLabel.textColor = .white
        moneyTitleLabel.text = "남은 금액"
        
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 3
        numFormatter.numberStyle = .decimal
        moneyValueLabel.backgroundColor = .systemPink
        moneyValueLabel.layer.cornerRadius = moneyValueLabel.frame.width / 2
        moneyValueLabel.font = UIFont.systemFont(ofSize: 40)
        moneyValueLabel.textColor = .white
        moneyValueLabel.textAlignment = .right
        print("totlaMoney: \(totalMoney)at \(#function)")
        moneyValueLabel.text = "₩ \((numFormatter.string(from: NSNumber(value: totalMoney))) ?? "0")"
        
        dividerView2.backgroundColor = .gray
        
        itemListTabelView.backgroundColor = .systemYellow
        itemListTabelView.rowHeight = 100
        itemListTabelView.dataSource = self
        itemListTabelView.register(ItemListTableViewCell.self, forCellReuseIdentifier: ItemListTableViewCell.idendifier)
        
        addButton.backgroundColor = .systemGreen
        addButton.layer.cornerRadius = addButtonSize.widthHeight / 2
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.addTarget(self, action: #selector(addAccountList(_:)), for: .touchUpInside)
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        [calendar, dividerView1, moneyTitleLabel, moneyValueLabel, dividerView2, itemListTabelView, addButton].forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        [calendar, itemListTabelView].forEach({
            NSLayoutConstraint.activate([
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        })
        
        [dividerView1, dividerView2].forEach({
            NSLayoutConstraint.activate([
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            $0.heightAnchor.constraint(equalToConstant: 3)])
        })
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: self.topAnchor),
            calendar.heightAnchor.constraint(equalToConstant: 250),
            
            dividerView1.topAnchor.constraint(equalTo: calendar.bottomAnchor),
            
            moneyTitleLabel.topAnchor.constraint(equalTo: dividerView1.bottomAnchor),
            moneyTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            moneyTitleLabel.trailingAnchor.constraint(equalTo: moneyValueLabel.leadingAnchor),
            moneyTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            moneyValueLabel.topAnchor.constraint(equalTo: dividerView1.bottomAnchor),
            moneyValueLabel.leadingAnchor.constraint(equalTo: moneyTitleLabel.trailingAnchor),
            moneyValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            moneyValueLabel.heightAnchor.constraint(equalToConstant: 50),
            
            dividerView2.topAnchor.constraint(equalTo: moneyTitleLabel.bottomAnchor),
            
            itemListTabelView.topAnchor.constraint(equalTo: dividerView2.bottomAnchor),
            itemListTabelView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            addButton.widthAnchor.constraint(equalToConstant: addButtonSize.widthHeight),
            addButton.heightAnchor.constraint(equalToConstant: addButtonSize.widthHeight),
            addButton.trailingAnchor.constraint(equalTo: itemListTabelView.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: itemListTabelView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Selector
    @objc func addAccountList(_ sender: UIButton) {
        // present add Account VC delegate
        if selectTodayFlag == true {
            delegate?.presentView()
        } else {
            // do nothing
        }
    }
}

extension AccountView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectTodayFlag == true {
            return (spendingDataInfo[todayDate] ?? [SpendingData]()).count
        } else {
            return (spendingDataInfo[selectedDate] ?? [SpendingData]()).count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.idendifier, for: indexPath) as? ItemListTableViewCell else { return UITableViewCell()}
        if selectTodayFlag == true {
            cell.setupUI(with: todayDate, index: indexPath.row)
        } else {
            cell.setupUI(with: selectedDate, index: indexPath.row)
        }
        
        return cell
    }
    
    
}

extension AccountView: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        selectedDate = formatter.string(from: date)
        selectedDate = dateFormatter.string(from: date)
        if selectedDate == todayDate {
            selectTodayFlag = true
        } else {
            selectTodayFlag = false
        }
        print(selectedDate)
        itemListTabelView.reloadData()
    }
}
