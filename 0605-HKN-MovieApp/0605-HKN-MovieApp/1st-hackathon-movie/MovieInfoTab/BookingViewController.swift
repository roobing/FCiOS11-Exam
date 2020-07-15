//
//  BookingViewController.swift
//  1st-hackathon-movie
//
//  Created by Woobin Cheon on 2020/06/03.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController {

    let movieImageView =  UIImageView()
    let payButton = UIButton()
    let userNameTextField = UITextField()
    let containerView = UIView()
    
    var userName: String = ""
    var movieIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setUI()
        setConstraints()

    }

    func setNavigation() {
        navigationItem.title = "예매하기"
    }

    func setUI() {


        movieImageView.backgroundColor = .darkGray
        view.addSubview(movieImageView)

        containerView.backgroundColor = .systemGray
        view.addSubview(containerView)

        userNameTextField.placeholder = "이름"
        userNameTextField.backgroundColor = .brown
        userNameTextField.delegate = self
        containerView.addSubview(userNameTextField)

        payButton.setTitle("결제", for: .normal)
        payButton.addTarget(self, action: #selector(payAction), for: .touchUpInside)
        payButton.backgroundColor = .lightGray
        view.addSubview(payButton)

    }

    func setConstraints() {
        let guide = view.safeAreaLayoutGuide

        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 50).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10).isActive = true
        containerView.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 300).isActive = true


        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        userNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
        userNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true


        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        payButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -30).isActive = true
        payButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        payButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }

    @objc func payAction(_ sender: UIButton) {
        alert()
    }

    func alert() {
        let alertController = UIAlertController(title: "결제", message: "영화제목: \(movieList[self.movieIndex].title) \n 상영시간: \(movieList[self.movieIndex].runningTime) \n 예매자 성함: \(self.userName) \n 좌석번호: N90", preferredStyle: .alert)
        let payAction = UIAlertAction(title: "확인", style: .default, handler: {(_) in
            BookingInfo.shared.bookingInfo.bookingNum = (1...255).randomElement() ?? 0
            BookingInfo.shared.bookingInfo.userName = self.userName
            BookingInfo.shared.bookingInfo.movieName = movieList[self.movieIndex].title
            BookingInfo.shared.bookingInfo.movieTime = movieList[self.movieIndex].runningTime
            BookingInfo.shared.bookingInfo.seatNum = "N90"
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {(_) in
            //do something
        })

        alertController.addAction(payAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
}
extension BookingViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }



    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        self.view.endEditing(true)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        userName = textField.text ?? ""
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
