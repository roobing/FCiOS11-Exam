//
//  TestTableViewCell.swift
//  CafeSpot
//
//  Created by Woobin Cheon on 2020/07/13.
//  Copyright © 2020 Giftbot. All rights reserved.
// 망할 스크롤뷰

import UIKit

class DetailViewImageCell: UITableViewCell {

    @IBOutlet var imageTitleLabel: UILabel!
    @IBOutlet var imageDescriptionLabel: UILabel!
    @IBOutlet var testImageView: UIImageView!
    
    func setImage(with cafeinfo: CafeList) {
        testImageView.image = UIImage(named: cafeinfo.title)
        imageTitleLabel.text = cafeinfo.title
        imageDescriptionLabel.text = cafeinfo.description
//        pageControll.
    }
}
