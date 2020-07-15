//
//  DetailImageView.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/22/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

class DetailImageView: UIImageView {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI
    private func configureUI() {
        
    }
    
}
