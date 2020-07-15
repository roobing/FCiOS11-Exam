//
//  HomeCollectionViewCell.swift
//  CafeSpot
//
//  Created by Woobin Cheon on 2020/07/12.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

protocol HomeViewCollectionDelegate: class {
    func setupFavoriteState()
}

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet var cafeImageView: UIImageView!
    @IBOutlet var cafeNameLabel: UILabel!
    @IBOutlet var cafeDescriptionLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    func cellConfig(cafeImage image: String, cafeName name: String, cafeDescription description: String, isFavorite isfavorite: Bool, indexPath indexpath: IndexPath) {
        cafeImageView.image = UIImage(named: image)
        cafeNameLabel.text = name
        cafeDescriptionLabel.text = description
        favoriteButton.tag = indexpath.item
        
        switch isfavorite {
        case true:
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteButton.tintColor = .systemPink
            favoriteButton.setTitleColor(.systemPink, for: .normal)
        default:
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteButton.tintColor = .white
        }
        
    }
    
    
}
