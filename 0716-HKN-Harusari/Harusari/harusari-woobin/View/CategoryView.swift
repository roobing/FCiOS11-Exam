//
//  CategoryView.swift
//  harusari-woobin
//
//  Created by Woobin Cheon on 2020/07/17.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class CategoryView: UIView {

    var imageViewArray = [UIImageView]()
    let imageNameArray = ["bag", "cart", "creditcard", "car", "tram.fill", "airplane", "keyboard", "tv"]
    
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
        for i in imageNameArray.indices {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: imageNameArray[i])
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10
            imageViewArray.append(imageView)
        }
        print(imageViewArray.indices)
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        
        imageViewArray.forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
        })
        
        for i in imageViewArray.indices {
            imageViewArray[i].widthAnchor.constraint(equalToConstant: 50).isActive = true
            if i == 0 {
                print("if")
                imageViewArray[i].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            } else {
                print("else")
                imageViewArray[i].leadingAnchor.constraint(equalTo: imageViewArray[i-1].trailingAnchor, constant: 10).isActive = true
            }
        }
        imageViewArray[7].trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
    }
}
