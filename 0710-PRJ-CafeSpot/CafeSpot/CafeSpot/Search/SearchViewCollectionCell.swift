//
//  SearchViewCollectionCell.swift
//  CafeSpot
//
//  Created by Woobin Cheon on 2020/07/13.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class SearchViewCollectionCell: UICollectionViewCell {
    @IBOutlet var annotationImageView: UIImageView!
    @IBOutlet var annotationTitleLabel: UILabel!
    @IBOutlet var annotationDescriptionLabel: UILabel!
    
    
    func setAnnotationCell(with cafeInfo: CafeList) {
        annotationImageView.image = UIImage(named: cafeInfo.title)
        annotationTitleLabel.text = cafeInfo.title
        annotationDescriptionLabel.text = cafeInfo.description
    }
}
