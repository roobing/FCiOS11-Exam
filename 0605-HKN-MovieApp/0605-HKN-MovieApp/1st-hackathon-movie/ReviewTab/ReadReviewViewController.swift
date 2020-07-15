//
//  ReadReviewViewController.swift
//  1st-hackathon-movie
//
//  Created by Woobin Cheon on 2020/06/05.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class ReadReviewViewController: UIViewController {

    let containerView: UIView = UIView()
    let pictureView: UIImageView = UIImageView()
    let rateLabel: UILabel = UILabel()
    let userNameLabel: UILabel = UILabel()
    let inputUserNameLabel: UILabel = UILabel()
    let inputTitleLabel: UILabel = UILabel()
    let inputRateLabel: UILabel = UILabel()
    let inputContentsView: UITextView = UITextView()
    let movieImageView: UIImageView = UIImageView()
    
    var reviewIndex: Int = 0
    
//    let Button: UIButton = UIButton()
 
    struct containerValues {
        static let width: CGFloat = 300
        static let height: CGFloat = 450
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImage = UIImageView(image: UIImage(named: "back-lala"))
        backImage.frame = view.frame
        view.addSubview(backImage)
        
        setUI()
        setNavigation()

    }
    
    func setNavigation() {
        navigationItem.title = "후기보기"
    }
    
func setUI() {
    
    containerView.frame.origin = CGPoint(x: view.center.x - containerValues.width / 2, y: 260)
    containerView.frame.size = CGSize(width: containerValues.width, height: containerValues.height)
    containerView.backgroundColor = .systemBackground
    containerView.alpha = 0.8
    containerView.layer.cornerRadius = 20
    view.addSubview(containerView)
    
    pictureView.frame.origin = CGPoint(x: 10, y: 10)
    pictureView.frame.size = CGSize(width: 150, height: 150)
    pictureView.backgroundColor = .systemYellow
    inputRateLabel.clipsToBounds = true
    pictureView.layer.cornerRadius = 20
    pictureView.image = ReviewInfo.shared.reviewInfo[reviewIndex].image
    containerView.addSubview(pictureView)
    
    userNameLabel.frame.origin = CGPoint(x: pictureView.frame.size.width + 20, y: 10)
    userNameLabel.frame.size = CGSize(width: 110, height: 30)
    userNameLabel.backgroundColor = .systemGreen
    userNameLabel.clipsToBounds = true
    userNameLabel.layer.cornerRadius = 5
    userNameLabel.text = "작성자"
    userNameLabel.textAlignment = .center
    containerView.addSubview(userNameLabel)
    
    inputUserNameLabel.frame.origin = CGPoint(x: pictureView.frame.size.width + 20, y: 50)
    inputUserNameLabel.frame.size = CGSize(width: 110, height: 30)
    inputUserNameLabel.clipsToBounds = true
    inputUserNameLabel.layer.cornerRadius = 5
    inputUserNameLabel.textAlignment = .center
    inputUserNameLabel.text = ReviewInfo.shared.reviewInfo[reviewIndex].userName
    containerView.addSubview(inputUserNameLabel)
    
    rateLabel.frame.origin = CGPoint(x: pictureView.frame.size.width + 20, y: 90)
    rateLabel.frame.size = CGSize(width: 110, height: 30)
    rateLabel.clipsToBounds = true
    rateLabel.layer.cornerRadius = 5
    rateLabel.text = "평점"
    rateLabel.textAlignment = .center
    containerView.addSubview(rateLabel)
    
    inputRateLabel.frame.origin = CGPoint(x: pictureView.frame.size.width + 20, y: 130)
    inputRateLabel.frame.size = CGSize(width: 110, height: 30)
    inputRateLabel.clipsToBounds = true
    inputRateLabel.layer.cornerRadius = 20
    inputRateLabel.text = ReviewInfo.shared.reviewInfo[reviewIndex].rate
    inputRateLabel.textAlignment = .center
    containerView.addSubview(inputRateLabel)
    
    inputTitleLabel.frame.origin = CGPoint(x: 10, y: pictureView.frame.size.height + 20)
    inputTitleLabel.frame.size = CGSize(width: 280, height: 40)
    inputTitleLabel.backgroundColor = .systemGreen
    inputTitleLabel.clipsToBounds = true
    inputTitleLabel.layer.cornerRadius = 20
    inputTitleLabel.text = ReviewInfo.shared.reviewInfo[reviewIndex].title
    inputTitleLabel.textAlignment = .center
    containerView.addSubview(inputTitleLabel)
    
    inputContentsView.frame.origin = CGPoint(x: 10, y: pictureView.frame.size.height + 70)
    inputContentsView.frame.size = CGSize(width: 280, height: 220)
    inputContentsView.backgroundColor = .systemGray
    inputRateLabel.clipsToBounds = true
    inputContentsView.layer.cornerRadius = 20
    inputContentsView.text = ReviewInfo.shared.reviewInfo[reviewIndex].contents
    containerView.addSubview(inputContentsView)
    
    movieImageView.frame.origin = CGPoint(x: view.center.x - 75, y: 100)
    movieImageView.frame.size = CGSize(width: 150, height: 150)
    movieImageView.backgroundColor = .systemYellow
    movieImageView.clipsToBounds = true
    movieImageView.layer.cornerRadius = 20
    movieImageView.image = ReviewInfo.shared.reviewInfo[reviewIndex].movieImage
    view.addSubview(movieImageView)
//    writeButton.frame.origin = CGPoint(x: view.center.x - containerValues.width / 4, y: containerValues.height + 150)
//    writeButton.frame.size = CGSize(width: containerValues.width / 2, height: containerValues.height / 6)
//    writeButton.backgroundColor = .systemBlue
//    writeButton.setTitle("글쓰기", for: .normal)
//    writeButton.layer.cornerRadius = 20
//    writeButton.addTarget(self, action: #selector(saveReview(_:)), for: .touchUpInside)
//    view.addSubview(writeButton)
    
}
}
