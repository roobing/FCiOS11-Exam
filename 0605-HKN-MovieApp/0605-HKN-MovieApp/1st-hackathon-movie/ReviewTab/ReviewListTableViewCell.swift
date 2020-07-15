//
//  ReviewListTableViewCell.swift
//  1st-hackathon-movie
//
//  Created by Woobin Cheon on 2020/06/05.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class ReviewListTableViewCell: UITableViewCell {
    
    var reviewListImage: UIImageView = UIImageView()
    var reviewMovieImage: UIImageView = UIImageView()
    var reviewTitleLabel: UILabel = UILabel()
    var reviewRateLabel: UILabel = UILabel()
    var reviewUserNameLabel: UILabel = UILabel()
    static let reivewListCellID: String = "reviewListCellID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        reviewListImage.frame = CGRect(x: 5, y: 5, width: 90, height: 90)
        reviewListImage.contentMode = .scaleToFill
        contentView.addSubview(reviewListImage)
        
        reviewTitleLabel.frame = CGRect(x: 110, y: 0, width: 150, height: 40)
//        reviewTitleLabel.backgroundColor = .brown
        reviewTitleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        contentView.addSubview(reviewTitleLabel)
        
        reviewRateLabel.frame = CGRect(x: 110, y: 40, width: 100, height: 30)
//        reviewRateLabel.backgroundColor = .yellow
        reviewTitleLabel.font = .preferredFont(forTextStyle: .headline)
        contentView.addSubview(reviewRateLabel)
        
        reviewUserNameLabel.frame = CGRect(x: 110, y: 70, width: 100, height: 30)
//        reviewUserNameLabel.backgroundColor = .yellow
        reviewTitleLabel.font = .preferredFont(forTextStyle: .headline)
        contentView.addSubview(reviewUserNameLabel)
        
        reviewMovieImage.frame = CGRect(x: 275, y: 5, width: 90, height: 90)
        reviewMovieImage.contentMode = .scaleToFill
        contentView.addSubview(reviewMovieImage)
        
        
    }
}
