//
//  KeypadShape.swift
//  CalculatorExample
//
//  Created by Woobin Cheon on 2020/06/09.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

@IBDesignable
final class KeypadShape: UIButton {
    
    var keypadRadius: CGFloat = 40 {
        didSet{
            layer.cornerRadius = keypadRadius
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        keypadRadius = frame.width / 2
    }
    
}
