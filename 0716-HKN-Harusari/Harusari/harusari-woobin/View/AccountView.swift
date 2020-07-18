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
    var spendingDataList = [SpendingData]()

    let dividerView1 = UIView()
    
    let moneyTitleLabel = UILabel()
    let moneyValueLabel = UILabel()
    
    let dividerView2 = UIView()
    
    let itemListTabelView = UITableView()
    
    let addButton = UIButton()
    
    weak var delegate: PresentDelegate?
    
    struct addButtonSize {
        static let widthHeight: CGFloat = 70
    }
    
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
        calendar.dataSource = self
        calendar.delegate = self
        
        dividerView1.backgroundColor = .gray
        
        moneyTitleLabel.backgroundColor = .systemBlue
        moneyTitleLabel.font = UIFont.systemFont(ofSize: 35)
        moneyTitleLabel.textColor = .white
        moneyTitleLabel.text = "남은 금액"
        
        moneyValueLabel.backgroundColor = .systemPink
        moneyValueLabel.layer.cornerRadius = moneyValueLabel.frame.width / 2
        moneyValueLabel.font = UIFont.systemFont(ofSize: 40)
        moneyValueLabel.textColor = .white
        moneyValueLabel.textAlignment = .right
        moneyValueLabel.text = "₩ 100,000"
        
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
        delegate?.presentView()
    }
}

extension AccountView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        spendingDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.idendifier, for: indexPath) as? ItemListTableViewCell else { return UITableViewCell()}
//        switch selectedDate {
//        case 1:
//            cell.setupUI(UIImage(systemName: "flame")!, 2000, "테스트1")
//        case 2:
//            cell.setupUI(UIImage(systemName: "bolt")!, 3000, "테스트2")
//        case 3:
//            cell.setupUI(UIImage(systemName: "ant")!, 4000, "테스트2")
//        default:
//            break
//        }
        
        return cell
    }
    
    
}

extension AccountView: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "ko-KR")
//        selectedDate = formatter.string(from: date)
        test["date"] = formatter.string(from: date)
        print(selectedDate)
        itemListTabelView.reloadData()
    }
}
