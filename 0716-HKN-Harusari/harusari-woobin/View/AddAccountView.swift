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
//    func transferTextFieldContent(_ text: String)
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
    let categoryCollection = CategoryView()
    
    let detailTitleLabel = UILabel()
    let detailTextField = UITextField()
    
    
    
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
        categoryScrollView.contentSize = CGSize(width: 500, height: 200)
        
        categoryCollection.backgroundColor = .brown

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
        [cancelButton, titleLabel, confirmButton, dividerView, monetaryUnitLabel, moneyTextField, moneyTitleLabel, categoryTitleLabel, categoryScrollView, categoryCollection, detailTitleLabel, detailTextField].forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        categoryScrollView.addSubview(categoryCollection)
        
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
//            monetaryUnitLabel.widthAnchor.constraint(equalToConstant: 60),
//            monetaryUnitLabel.heightAnchor.constraint(equalToConstant: 60),
            
            moneyTextField.topAnchor.constraint(equalTo: moneyTitleLabel.bottomAnchor),
            moneyTextField.leadingAnchor.constraint(equalTo: monetaryUnitLabel.trailingAnchor),
            moneyTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            moneyTextField.heightAnchor.constraint(equalTo: moneyTitleLabel.heightAnchor),
//            moneyTextField.bottomAnchor.constraint(equalTo: categoryTitleLabel.topAnchor),
        
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
        
        
    }
    
    // MARK: - Selector
    @objc func cancelButtonAction(_ sender: UIButton) {
        delegate?.dismissView()
    }
    
    @objc func confirmButtonAction(_ sender: UIButton) {
        //
    }
}

extension AddAccountView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var result = true
        switch textField.tag {
        case 0:
            if let removeAllSeparator = textField.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "") {
                print(removeAllSeparator)
                var beforeFormattedString = removeAllSeparator + string
                if numberFormatter.number(from: string) != nil {
                    if let formattedNumber = numberFormatter.number(from: beforeFormattedString),
                        let formattedString = numberFormatter.string(from: formattedNumber) {
                        textField.text = formattedString
                        result = false
                    }
                } else {
                    if string == "" {
                        let lastIndex = beforeFormattedString.index(beforeFormattedString.endIndex, offsetBy: -1)
                        beforeFormattedString = String(beforeFormattedString[..<lastIndex])
                        if let formattedNumber = numberFormatter.number(from: beforeFormattedString),
                            let formattedString = numberFormatter.string(from: formattedNumber) {
                            textField.text = formattedString
                            result = false
                        }
                    } else {
                        result = false
                    }
                }
            }
        case 1:
            result = true
            
        default:
            result = true
        }
        return result
    }
}
