//
//  AddAccountView.swift
//  harusari-woobin
//
//  Created by Woobin Cheon on 2020/07/17.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit
import Firebase




protocol AddAccountViewDelegate: class {
    func dismissView()
    func changeButtonBackground(_ sender: UIButton) -> UIColor // Mod by woobin on 0721
    func spendingInfoTransfer(_ category: String, _ money: Int, _ memo: String)
    func calculateTotalMoney(_ money: Int)
    func makeAlert(_ message: String)
}

class AddAccountView: UIView {
    let firestore = Firestore.firestore()
    
    let backgroundImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "whiteBackground")
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 1
        return imageView
    }()
    
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
    var categoryButtons = [UIButton]()
    var categoryButtonsFlag = false
    
    let detailTitleLabel = UILabel()
    let detailTextField = UITextField()
    
    var categoryImageName = ""
    var money = 0
    var memo = ""
   var prevButtonTag: Int? = nil // Add by woobin on 0721
    
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
        
//        cancelButton.backgroundColor = .systemGreen
        cancelButton.setTitle("취소", for: .normal)
//        cancelButton.titleLabel?.backgroundColor = .systemGreen
        cancelButton.titleLabel!.font = UIFont(name: "BMEULJIRO", size: 20)
        cancelButton.setTitleColor(UIColor(rgb: 0x017831), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction(_:)), for: .touchUpInside)
        
//        titleLabel.backgroundColor = .systemGreen
        titleLabel.text = "내역 추가"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "BMEULJIRO", size: 30)
        
//        confirmButton.backgroundColor = .systemBlue
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.titleLabel!.font = UIFont(name: "BMEULJIRO", size: 20)
//        confirmButton.titleLabel?.backgroundColor = .systemGreen
        confirmButton.setTitleColor(UIColor(rgb: 0x017831), for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmButtonAction(_:)), for: .touchUpInside)
        
        dividerView.backgroundColor = UIColor(rgb: 0x017831)
        
//        moneyTitleLabel.backgroundColor = .systemGreen
        moneyTitleLabel.text = "금액"
        moneyTitleLabel.font = UIFont(name: "BMEULJIRO", size: 30)
    
        
        moneyTextField.delegate = self
        moneyTextField.keyboardType = .numberPad
//        moneyTextField.backgroundColor = .systemTeal
        moneyTextField.textAlignment = .right
        moneyTextField.font = UIFont(name: "BMEULJIRO", size: 30)
        moneyTextField.clearButtonMode = .always
        moneyTextField.placeholder = "금액 입력"
        moneyTextField.tag = 0
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 3
        
//        monetaryUnitLabel.backgroundColor = .systemOrange
        monetaryUnitLabel.text = "₩"
        monetaryUnitLabel.textAlignment = .center
        monetaryUnitLabel.font = UIFont(name: "BMEULJIRO", size: 30)
        
//        categoryTitleLabel.backgroundColor = .systemGreen®
        
        categoryTitleLabel.text = "카테고리"
        categoryTitleLabel.font = UIFont(name: "BMEULJIRO", size: 35)
        
//        categoryScrollView.backgroundColor = .systemTeal
        let viewWidth = UIScreen.main.bounds.width
        categoryScrollView.contentSize = CGSize(width:viewWidth*2, height: 200)
        categoryScrollView.isPagingEnabled = true
        
        for i in imageNameArray.indices {
            let button = UIButton()
            button.setImage(UIImage(named: imageNameArray[i]), for: .normal)
            button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 60), forImageIn: .normal)
            button.tintColor = .darkGray
            button.backgroundColor = .clear
            button.contentMode = .scaleAspectFill
            button.clipsToBounds = true
            button.layer.cornerRadius = 10
//            button.layer.borderWidth = 2
//            button.layer.borderColor = UIColor.green.cgColor
            button.tag = i
            button.addTarget(self, action: #selector(categoryButtonDidTap(_:)), for: .touchUpInside)
            categoryButtons.append(button)
        }

//        detailTitleLabel.backgroundColor = .systemGreen
        detailTitleLabel.text = "내역"
        detailTitleLabel.font = UIFont(name: "BMEULJIRO", size: 35)
        
        detailTextField.delegate = self
        detailTextField.keyboardType = .default
        detailTextField.autocorrectionType = .no
//        detailTextField.backgroundColor = .systemTeal
        detailTextField.font = UIFont(name: "BMEULJIRO", size: 30)
        detailTextField.placeholder = "내역을 입력해주세요"
        detailTextField.clearButtonMode = .always
        detailTextField.tag = 1
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        [  cancelButton, titleLabel, confirmButton, dividerView, monetaryUnitLabel, moneyTextField, moneyTitleLabel, categoryTitleLabel, categoryScrollView, detailTitleLabel, detailTextField].forEach({
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
//            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
//            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
          
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
            
            moneyTitleLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 10),
            moneyTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
//            monetaryUnitLabel.topAnchor.constraint(equalTo: moneyTitleLabel.bottomAnchor),
            monetaryUnitLabel.centerYAnchor.constraint(equalTo: moneyTextField.centerYAnchor),
            monetaryUnitLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            moneyTextField.topAnchor.constraint(equalTo: moneyTitleLabel.bottomAnchor, constant: 15),
            moneyTextField.leadingAnchor.constraint(equalTo: monetaryUnitLabel.trailingAnchor),
            moneyTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            moneyTextField.heightAnchor.constraint(equalTo: moneyTitleLabel.heightAnchor),
        
            categoryTitleLabel.topAnchor.constraint(equalTo: monetaryUnitLabel.bottomAnchor, constant: 10),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            categoryScrollView.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 2),
            categoryScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoryScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            categoryScrollView.heightAnchor.constraint(equalToConstant: 200),
            
            detailTitleLabel.topAnchor.constraint(equalTo: categoryScrollView.bottomAnchor),
            detailTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            detailTextField.topAnchor.constraint(equalTo: detailTitleLabel.bottomAnchor),
            detailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
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
        
        guard let userUid = Auth.auth().currentUser?.uid else {return}
        
        guard var temp = totalMoney[selectedDate] else { fatalError("calculate total money error")}
         temp = temp - money
        if temp < 0 {
            delegate?.makeAlert("잔액 부족")
        } else if money == nil || memo == nil {
            delegate?.makeAlert("항목을 모두 작성해주세요")
        } else {
            // 카테고리 이미지(String), 사용 금액(Int), 내역(String)을 갖는 구조체 생성을 VC에 위임
            delegate?.spendingInfoTransfer(categoryImageName, money, memo)
            delegate?.calculateTotalMoney(money)
            delegate?.dismissView()
            categoryButtonsFlag = false
            self.firestore.collection("User").document(userUid).updateData([UserReference.balance: temp])
        }
    }
    
    @objc func categoryButtonDidTap(_ sender: UIButton) {
        categoryImageName = imageNameArray[sender.tag]
        sender.backgroundColor = delegate?.changeButtonBackground(sender)
        if let prevTag = prevButtonTag {
            categoryButtons[prevTag].backgroundColor = .clear
            prevButtonTag = prevTag
        } else {
            // do nothing
        }
        prevButtonTag = sender.tag
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
