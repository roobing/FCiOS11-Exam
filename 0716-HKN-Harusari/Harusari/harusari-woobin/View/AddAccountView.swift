//
//  AddAccountView.swift
//  harusari-woobin
//
//  Created by Woobin Cheon on 2020/07/17.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

protocol AddAccountViewDelegate: class {
    func dismissView()
    func changeButtonBackground(_ sender: UIButton, _ flag: Bool) -> UIColor
    func spendingInfoTransfer(_ money: Int, _ category: String, _ memo: String)
    func makeAlert()
}

class AddAccountView: UIView {
    
    let cancelButton = UIButton()
    let titleLabel = UILabel()
    let confirmButton = UIButton()
    
    let dividerView = UIView()
    
    let moneyTitleLabel = UILabel()
    let moneyTextField = UITextField()
    let monetaryUnitLabel = UILabel()
    let numberFormatter = NumberFormatter()
    
    let categoryTitleLabel = UILabel()
    let categoryScrollView = UIScrollView()
//    let categoryCollection = CategoryView()
    var categoryButtons = [UIButton]()
    var categoryButtonsFlag = false
    let imageNameArray = ["bag", "cart", "creditcard", "car", "tram.fill", "airplane", "keyboard", "tv"]
    
    let detailTitleLabel = UILabel()
    let detailTextField = UITextField()
    
    var categoryImageName = ""
    var money = 0
    var memo = ""
    
    weak var delegate: AddAccountViewDelegate?
   
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
        cancelButton.backgroundColor = .systemBlue
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction(_:)), for: .touchUpInside)
        
        titleLabel.backgroundColor = .systemRed
        titleLabel.text = "내역 추가"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        confirmButton.backgroundColor = .systemBlue
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        confirmButton.addTarget(self, action: #selector(confirmButtonAction(_:)), for: .touchUpInside)
        
        dividerView.backgroundColor = .green
        
        moneyTitleLabel.backgroundColor = .cyan
        moneyTitleLabel.text = "금액"
        moneyTitleLabel.font = UIFont.systemFont(ofSize: 40)
        
        moneyTextField.delegate = self
        moneyTextField.keyboardType = .numberPad
        moneyTextField.backgroundColor = .systemTeal
        moneyTextField.textAlignment = .right
        moneyTextField.font = UIFont.systemFont(ofSize: 35)
        moneyTextField.placeholder = "금액 입력"
        moneyTextField.tag = 0
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 3
        
        monetaryUnitLabel.backgroundColor = .systemOrange
        monetaryUnitLabel.text = "₩"
        monetaryUnitLabel.textAlignment = .center
        monetaryUnitLabel.font = UIFont.systemFont(ofSize: 35)
        
        categoryTitleLabel.backgroundColor = .cyan
        categoryTitleLabel.text = "카테고리"
        categoryTitleLabel.font = UIFont.systemFont(ofSize: 40)
        
        categoryScrollView.backgroundColor = .systemTeal
//        categoryScrollView.contentSize = CGSize(width: 8 * 95, height: 200)
        let viewWidth = UIScreen.main.bounds.width
        categoryScrollView.contentSize = CGSize(width:viewWidth*2, height: 200)
        categoryScrollView.isPagingEnabled = true
//        categoryCollection.backgroundColor = .brown
        
        for i in imageNameArray.indices {
            let button = UIButton()
            button.setImage(UIImage(systemName: imageNameArray[i]), for: .normal)
            button.backgroundColor = .clear
            button.contentMode = .scaleAspectFill
            button.clipsToBounds = true
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.white.cgColor
            button.tag = i
            button.addTarget(self, action: #selector(categoryButtonDidTap(_:)), for: .touchUpInside)
            categoryButtons.append(button)
        }

        detailTitleLabel.backgroundColor = .cyan
        detailTitleLabel.text = "내역"
        detailTitleLabel.font = UIFont.systemFont(ofSize: 40)
        
        detailTextField.delegate = self
        detailTextField.keyboardType = .default
        detailTextField.autocorrectionType = .no
        detailTextField.backgroundColor = .systemTeal
        detailTextField.font = UIFont.systemFont(ofSize: 35)
        detailTextField.placeholder = "내역을 입력해주세요"
        detailTextField.tag = 1
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        [cancelButton, titleLabel, confirmButton, dividerView, monetaryUnitLabel, moneyTextField, moneyTitleLabel, categoryTitleLabel, categoryScrollView, detailTitleLabel, detailTextField].forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        [cancelButton, titleLabel, confirmButton].forEach({
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: self.topAnchor),
                $0.bottomAnchor.constraint(equalTo: dividerView.topAnchor)
            ])
        })
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            
            confirmButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            dividerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 3),
            
            moneyTitleLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor),
            moneyTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            monetaryUnitLabel.topAnchor.constraint(equalTo: moneyTitleLabel.bottomAnchor),
            monetaryUnitLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            moneyTextField.topAnchor.constraint(equalTo: moneyTitleLabel.bottomAnchor),
            moneyTextField.leadingAnchor.constraint(equalTo: monetaryUnitLabel.trailingAnchor),
            moneyTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            moneyTextField.heightAnchor.constraint(equalTo: moneyTitleLabel.heightAnchor),
        
            categoryTitleLabel.topAnchor.constraint(equalTo: monetaryUnitLabel.bottomAnchor),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            categoryScrollView.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor),
            categoryScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoryScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            categoryScrollView.heightAnchor.constraint(equalToConstant: 200),
            
            detailTitleLabel.topAnchor.constraint(equalTo: categoryScrollView.bottomAnchor),
            detailTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            detailTextField.topAnchor.constraint(equalTo: detailTitleLabel.bottomAnchor),
            detailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            detailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            detailTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        categoryButtons.forEach({
            categoryScrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: 85).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 173).isActive = true
        })
        
        
        for i in categoryButtons.indices {
            switch i % 4 {
            case 0:
                if i < 4 {
                    categoryButtons[i].topAnchor.constraint(equalTo: categoryScrollView.topAnchor, constant: 10).isActive = true
                    categoryButtons[i].leadingAnchor.constraint(equalTo: categoryScrollView.leadingAnchor, constant: 10).isActive = true
                } else {
                    categoryButtons[i].topAnchor.constraint(equalTo: categoryScrollView.topAnchor, constant: 10).isActive = true
                    categoryButtons[i].leadingAnchor.constraint(equalTo: categoryButtons[i-3].trailingAnchor, constant: 20).isActive = true
                }
            case 1:
                categoryButtons[i].topAnchor.constraint(equalTo: categoryScrollView.topAnchor, constant: 10).isActive = true
                categoryButtons[i].leadingAnchor.constraint(equalTo: categoryButtons[i-1].trailingAnchor, constant: 10).isActive = true
            case 2:
                if i < 4 {
                    categoryButtons[i].topAnchor.constraint(equalTo: categoryButtons[i-2].bottomAnchor, constant: 10).isActive = true
                    categoryButtons[i].leadingAnchor.constraint(equalTo: categoryScrollView.leadingAnchor, constant: 10).isActive = true
                } else {
                    categoryButtons[i].topAnchor.constraint(equalTo: categoryButtons[i-2].bottomAnchor, constant: 10).isActive = true
                    categoryButtons[i].leadingAnchor.constraint(equalTo: categoryButtons[i-3].trailingAnchor, constant: 20).isActive = true
                }
            case 3:
                categoryButtons[i].topAnchor.constraint(equalTo: categoryButtons[i-2].bottomAnchor, constant: 10).isActive = true
                categoryButtons[i].leadingAnchor.constraint(equalTo: categoryButtons[i-1].trailingAnchor, constant: 10).isActive = true
            default:
                break
            }
        }
        
    }
    
    // MARK: - Selector
    @objc func cancelButtonAction(_ sender: UIButton) {
        delegate?.dismissView()
    }
    
    @objc func confirmButtonAction(_ sender: UIButton) {
        if totalMoney - money < 0 {
            delegate?.makeAlert()
        } else {
            delegate?.spendingInfoTransfer(money, categoryImageName, memo)
            print("\(spendingDataList) at \(#function)")
            delegate?.dismissView()
        }
    }
    
    @objc func categoryButtonDidTap(_ sender: UIButton) {
        categoryButtonsFlag = !categoryButtonsFlag
        categoryImageName = imageNameArray[sender.tag]
        print(categoryImageName)
        sender.backgroundColor = delegate?.changeButtonBackground(sender, categoryButtonsFlag)
    }
}
// MARK: - UITextFieldDelegate
extension AddAccountView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var result = true
        switch textField.tag {
        case 0:
            if let removeAllSeparator = textField.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "") {
                var beforeFormattedString = removeAllSeparator + string
                if numberFormatter.number(from: string) != nil {
                    if let formattedNumber = numberFormatter.number(from: beforeFormattedString),
                        let formattedString = numberFormatter.string(from: formattedNumber) {
                        money = Int(beforeFormattedString) ?? 0
                        print("\(money) at \(#function)")
                        textField.text = formattedString
                        result = false
                    }
                } else {
                    if string == "" {
                        let lastIndex = beforeFormattedString.index(beforeFormattedString.endIndex, offsetBy: -1)
                        beforeFormattedString = String(beforeFormattedString[..<lastIndex])
                        if let formattedNumber = numberFormatter.number(from: beforeFormattedString),
                            let formattedString = numberFormatter.string(from: formattedNumber) {
                            money = Int(beforeFormattedString) ?? 0
                            print("\(money) at \(#function)")
                            textField.text = formattedString
                            result = false
                        }
                    } else {
                        result = false
                    }
                }
            }
        default:
            result = true
        }
        return result
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            memo = textField.text ?? ""
        default:
            break
        }
    }
}
