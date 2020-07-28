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
    
    let backgroundImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "whiteBackground")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.2
        return imageView
    }()
    
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
        totalMoney.updateValue(Int(moneyFromRoulette ?? "0") ?? 0, forKey: selectedDate)
        // <===
        
        setupUI()
        setupConstraint()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Setup UI
    func setupUI() {
//        backgroundColor = UIColor(rgb: 0x017831)
        
        
        calendar.dataSource = self
                calendar.delegate = self
                
                dividerView1.backgroundColor = UIColor(rgb: 0x12b71a)
                
//                moneyTitleLabel.backgroundColor = UIColor(rgb: 0x12b71a)
                moneyTitleLabel.clipsToBounds = true
                moneyTitleLabel.layer.cornerRadius = 10
                moneyTitleLabel.font = UIFont(name: "BMEULJIRO", size: 30)
                moneyTitleLabel.textColor = UIColor(rgb: 0x12b71a)
                moneyTitleLabel.text = "남은 금액"
                
                
                numFormatter.minimumFractionDigits = 0
                numFormatter.maximumFractionDigits = 3
                numFormatter.numberStyle = .decimal
        //        moneyValueLabel.backgroundColor = .systemPink
                moneyValueLabel.layer.cornerRadius = moneyValueLabel.frame.width / 2
                moneyValueLabel.font = UIFont(name:"BMEULJIRO", size: 40)
                moneyValueLabel.textColor = .black
                moneyValueLabel.textAlignment = .right
                moneyValueLabel.text = "₩ \(UserDefaults.standard.string(forKey: UserReference.balance) ?? "0")"
                
                moneyValueLabel.text = "₩ \((numFormatter.string(from: NSNumber(value: totalMoney[selectedDate] ?? 0))) ?? "0")"
                
                dividerView2.backgroundColor = UIColor(rgb: 0x12b71a)
                
        itemListTabelView.backgroundColor = UIColor(rgb: 0xc4e8bf)
                itemListTabelView.rowHeight = 100
                itemListTabelView.dataSource = self
                itemListTabelView.register(ItemListTableViewCell.self, forCellReuseIdentifier: ItemListTableViewCell.idendifier)
                
//                addButton.backgroundColor = UIColor(rgb:0x017831)
                addButton.layer.cornerRadius = addButtonSize.widthHeight / 2
        //        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
//                addButton.setTitle("+", for: .normal)
//                addButton.setTitleColor(.white, for: .normal)
//                addButton.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        addButton.setImage(UIImage(named: "아이콘"), for: .normal)
        addButton.imageView?.contentMode = .scaleAspectFit
        addButton.layer.cornerRadius = addButton.frame.width / 2
                addButton.addTarget(self, action: #selector(addAccountList(_:)), for: .touchUpInside)
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        [backgroundImage, calendar ,dividerView1, moneyTitleLabel, moneyValueLabel, dividerView2, itemListTabelView, addButton].forEach({
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
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
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
    // FSCalendar
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
        
        itemListTabelView.reloadData()
    }
}
