//
//  AccountView.swift
//  harusari-woobin
//
//  Created by Woobin Cheon on 2020/07/16.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit
import FSCalendar

protocol AccountViewDelegate: class {
    func presentView()
    func changeDate(to date: String)
}

class AccountView: UIView {
    
    let calendar = FSCalendar()
    let dateFormatter = DateFormatter()

    let dividerView1 = UIView()
    
    let moneyTitleLabel = UILabel()
    let moneyValueLabel = UILabel()
    let numFormatter = NumberFormatter()
    
    let dividerView2 = UIView()
    
    let itemListTabelView = UITableView()
    
    let addButton = UIButton()
    var addButtonBottomConst: NSLayoutConstraint!
    
    weak var delegate: AccountViewDelegate?
    
    struct addButtonSize {
        static let widthHeight: CGFloat = 70
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // <=== 여기서 오늘날짜 데이터(String)을 생성
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "ko-KR")
        selectedDate = dateFormatter.string(from: Date())
        spendingDataInfo.updateValue([SpendingData](), forKey: selectedDate)
        totalMoney.updateValue(moneyFromRoulette, forKey: selectedDate)
        // <===
        
        setupUI()
        setupConstraint()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Setup UI
    func setupUI() {
        calendar.dataSource = self
        calendar.delegate = self
        
        dividerView1.backgroundColor = .green
        
        moneyTitleLabel.backgroundColor = .systemGreen
        moneyTitleLabel.font = UIFont.systemFont(ofSize: 35)
        moneyTitleLabel.textColor = .black
        moneyTitleLabel.text = "남은 금액"
        
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 3
        numFormatter.numberStyle = .decimal
//        moneyValueLabel.backgroundColor = .systemPink
        moneyValueLabel.layer.cornerRadius = moneyValueLabel.frame.width / 2
        moneyValueLabel.font = UIFont.systemFont(ofSize: 40)
        moneyValueLabel.textColor = .black
        moneyValueLabel.textAlignment = .right
        moneyValueLabel.text = "₩ \((numFormatter.string(from: NSNumber(value: totalMoney[selectedDate] ?? 0))) ?? "0")"
        
        dividerView2.backgroundColor = .green
        
//        itemListTabelView.backgroundColor = .systemGreen
        itemListTabelView.rowHeight = 100
        itemListTabelView.dataSource = self
        itemListTabelView.register(ItemListTableViewCell.self, forCellReuseIdentifier: ItemListTableViewCell.idendifier)
        
        addButton.backgroundColor = .systemGreen
        addButton.layer.cornerRadius = addButtonSize.widthHeight / 2
//        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 50)
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
            
            dividerView1.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 10),
            
            moneyTitleLabel.topAnchor.constraint(equalTo: dividerView1.bottomAnchor, constant: 10),
            moneyTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            moneyTitleLabel.trailingAnchor.constraint(equalTo: moneyValueLabel.leadingAnchor),
            moneyTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            moneyValueLabel.topAnchor.constraint(equalTo: dividerView1.bottomAnchor, constant: 10),
            moneyValueLabel.leadingAnchor.constraint(equalTo: moneyTitleLabel.trailingAnchor),
            moneyValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            moneyValueLabel.heightAnchor.constraint(equalToConstant: 50),
            
            dividerView2.topAnchor.constraint(equalTo: moneyTitleLabel.bottomAnchor, constant: 10),
            
            itemListTabelView.topAnchor.constraint(equalTo: dividerView2.bottomAnchor, constant: 10),
            itemListTabelView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            addButton.widthAnchor.constraint(equalToConstant: addButtonSize.widthHeight),
            addButton.heightAnchor.constraint(equalToConstant: addButtonSize.widthHeight),
            addButton.trailingAnchor.constraint(equalTo: itemListTabelView.trailingAnchor, constant: -20)
        ])
        addButtonBottomConst = addButton.bottomAnchor.constraint(equalTo: itemListTabelView.bottomAnchor, constant: -20)
        addButtonBottomConst.isActive = true
    }
    
    // MARK: - Selector
    @objc func addAccountList(_ sender: UIButton) {
        delegate?.presentView()
    }
}

extension AccountView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (spendingDataInfo[selectedDate] ?? [SpendingData]()).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.idendifier, for: indexPath) as? ItemListTableViewCell else { return UITableViewCell()}
        cell.setupUI(with: selectedDate, index: indexPath.row)
        return cell
    }
    
}

extension AccountView: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "ko-KR")
        let pickedDate = dateFormatter.string(from: date)
        delegate?.changeDate(to: pickedDate)
        if pickedDate == dateFormatter.string(from: Date()) {
            UIView.animate(withDuration: 0.5, animations: {
                self.addButtonBottomConst.constant = -20
                self.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.addButtonBottomConst.constant = 120
                self.layoutIfNeeded()
            })
        }
        moneyValueLabel.text = "₩ \((numFormatter.string(from: NSNumber(value: totalMoney[selectedDate] ?? 0))) ?? "0")"
        itemListTabelView.reloadData()
    }
}
