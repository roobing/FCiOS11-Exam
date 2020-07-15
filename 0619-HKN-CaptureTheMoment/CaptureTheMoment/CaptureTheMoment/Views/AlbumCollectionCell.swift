//
//  AlbumCollectionCell.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/22/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

final class AlbumCollectionCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "AlbumCollectionCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    
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
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: self.frame.height),
            imageView.widthAnchor.constraint(equalToConstant: self.frame.width),
        ])
    }
}
