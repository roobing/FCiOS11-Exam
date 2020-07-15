//
//  BookingInfoTapViewController.swift
//  1st-hackathon-movie
//
//  Created by Woobin Cheon on 2020/06/03.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class BookingInfoTapViewController: UIViewController {
    
    
    let containerView: UIView = UIView()
    let bookingNumLabel: UILabel = UILabel()
    let userNameLabel: UILabel = UILabel()
    let movieNameLabel: UILabel = UILabel()
    let movieTimeLabel: UILabel = UILabel()
    let seatNumLabel: UILabel = UILabel()
    
    let checkButton: UIButton = UIButton()
    
    let mainImageView = UIImageView()
    
    struct containerValues {
        static let width: CGFloat = 300
        static let height: CGFloat = 450
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImageView.frame = view.frame
        mainImageView.image = UIImage(named: "back-lala")
        view.addSubview(mainImageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        guard BookingInfo.shared.bookingInfo.bookingNum != nil else {
//            noBookingNotice()
//            return
//        }
        print(reservation?.title)
        guard reservation?.title != nil else {
            noBookingNotice()
            return
        }
        setUI()
    }
    
    func noBookingNotice() {
        for tempView in containerView.subviews {
            tempView.removeFromSuperview()
        }
        
        checkButton.removeFromSuperview()
        
        containerView.frame.origin = CGPoint(x: view.center.x - containerValues.width / 2, y: 50)
        containerView.frame.size = CGSize(width: containerValues.width, height: containerValues.height)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0.8
        containerView.layer.cornerRadius = 20
        view.addSubview(containerView)
        
        bookingNumLabel.frame.origin = CGPoint(x: 0, y: 0)
        bookingNumLabel.frame.size = CGSize(width: containerValues.width, height: containerValues.height / 5)
        bookingNumLabel.text = "예매내역 없음"
        bookingNumLabel.textAlignment = .center
        bookingNumLabel.clipsToBounds = true
        bookingNumLabel.layer.cornerRadius = 20
        containerView.addSubview(bookingNumLabel)
    }
    
    func setUI() {
        containerView.frame.origin = CGPoint(x: view.center.x - containerValues.width / 2, y: 50)
        containerView.frame.size = CGSize(width: containerValues.width, height: containerValues.height)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0.8
        containerView.layer.cornerRadius = 20
        view.addSubview(containerView)
        
        bookingNumLabel.frame.origin = CGPoint(x: 0, y: 0)
        bookingNumLabel.frame.size = CGSize(width: containerValues.width, height: containerValues.height / 5)
        bookingNumLabel.numberOfLines = 2
        bookingNumLabel.lineBreakMode = .byCharWrapping
        bookingNumLabel.text = "모바일 티켓번호: \(BookingInfo.shared.bookingInfo.bookingNum ?? 0)"
        bookingNumLabel.clipsToBounds = true
        bookingNumLabel.layer.cornerRadius = 20
        containerView.addSubview(bookingNumLabel)
        
        movieNameLabel.frame.origin = CGPoint(x: 0, y: containerValues.height / 5)
        movieNameLabel.frame.size = CGSize(width: containerValues.width, height: containerValues.height / 5)
//        movieNameLabel.text = "영화 제목: \(BookingInfo.shared.bookingInfo.movieName ?? "")"
//        print(reservation!.title)
        movieNameLabel.text = "영화 제목: \(reservation?.title ?? "")"
        movieNameLabel.layer.cornerRadius = 20
        containerView.addSubview(movieNameLabel)
        
        movieTimeLabel.frame.origin = CGPoint(x: 0, y: (containerValues.height / 5)*2)
        movieTimeLabel.frame.size = CGSize(width: containerValues.width, height: containerValues.height / 5)
//        movieTimeLabel.text = "상영 시간: \(BookingInfo.shared.bookingInfo.movieTime ?? "")"
        movieTimeLabel.text = "상영 시간: \(reservation?.showTime ?? "")"
        movieTimeLabel.layer.cornerRadius = 20
        containerView.addSubview(movieTimeLabel)
        
        userNameLabel.frame.origin = CGPoint(x: 0, y: (containerValues.height / 5)*3)
        userNameLabel.frame.size = CGSize(width: containerValues.width, height: containerValues.height / 5)
        userNameLabel.text = "가격: \(reservation?.price ?? "")"
        //        userNameLabel.text = "예매자 성함: \(BookingInfo.shared.bookingInfo.userName ?? "")"
        userNameLabel.layer.cornerRadius = 20
        containerView.addSubview(userNameLabel)
        
        seatNumLabel.frame.origin = CGPoint(x: 0, y: (containerValues.height / 5)*4)
        seatNumLabel.frame.size = CGSize(width: containerValues.width, height: containerValues.height / 5)
//        seatNumLabel.text = "좌석 번호: \(BookingInfo.shared.bookingInfo.seatNum ?? "")"
        seatNumLabel.text = "상영관: \(reservation?.screen ?? "")"
        seatNumLabel.clipsToBounds = true
        seatNumLabel.layer.cornerRadius = 20
        containerView.addSubview(seatNumLabel)
        
        checkButton.frame.origin = CGPoint(x: view.center.x - containerValues.width / 2, y: (containerValues.height / 5)*6)
        checkButton.frame.size = CGSize(width: containerValues.width, height: containerValues.height / 5)
        checkButton.backgroundColor = .systemBlue
        checkButton.setTitle("입장 확인", for: .normal)
        checkButton.addTarget(self, action: #selector(resetBookingInfo), for: .touchUpInside)
        checkButton.layer.cornerRadius = 20
        view.addSubview(checkButton)
        
    }
    
    @objc func resetBookingInfo(_ sender: UIButton) {
        alert()
        
    }
    
    func alert() {
        let alertController = UIAlertController(title: "개소금 확인", message: "당신은 개소금입니까?", preferredStyle: .alert)
        let payAction = UIAlertAction(title: "확인", style: .default, handler: {(_) in
//            BookingInfo.shared.bookingInfo.bookingNum = nil
//            BookingInfo.shared.bookingInfo.userName = nil
//            BookingInfo.shared.bookingInfo.movieName = nil
//            BookingInfo.shared.bookingInfo.movieTime = nil
//            BookingInfo.shared.bookingInfo.seatNum = nil
            reservation?.title = ""
            reservation?.showTime = ""
            reservation?.price = ""
            reservation?.screen = ""
            self.noBookingNotice()
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {(_) in
            //do something
        })

        alertController.addAction(payAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
    
}

