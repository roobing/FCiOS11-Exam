//
//  ChoiceViewController.swift
//  MovieTheater
//
//  Created by 박종덕 on 2020/06/05.
//  Copyright © 2020 example. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController {
  var movie: Movie!
  
  let adultPrice: Int! = 11000
  
  let label_theater = UILabel()
  let label_displayTheater = UILabel()
  
  let label_screen = UILabel()
  let label_displayScreen = UILabel()
  
  let label_title = UILabel()
  let label_displayTitle = UILabel()
  
  let label_date = UILabel()
  let label_displayDate = UILabel()
  
  let label_showTime = UILabel()
  let label_displayShowTime = UILabel()
  
  let label_price = UILabel()
  let label_displayPrice = UILabel()
  
  let label_adultNumber = UILabel()
  let label_displayAdultNumber = UILabel()
  
  var x = 30
  var y = 180
  
  var x2 = 150
  var y2 = 180
  
  
  let btn_reserved = UIButton()
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    
    setLabel(label: label_theater, text: "극장")
    setLabel2(label: label_displayTheater, text: "강변점")
    setLabel(label: label_screen, text: "상영관")
    setLabel2(label: label_displayScreen, text: "1관")
    setLabel(label: label_title, text: "영화명")
    setLabel2(label: label_displayTitle, text: "\(movie.title)")
    setLabel(label: label_date, text: "날짜")
    setLabel2(label: label_displayDate, text: "2020.06.05 (금)")
    setLabel(label: label_showTime, text: "상영 시간")
    setLabel2(label: label_displayShowTime, text: "20:30")
    
    
    setLabel(label: label_adultNumber, text: "인원")
    setLabel2(label: label_displayAdultNumber, text: "1")
    setLabel(label: label_price, text: "가격")
    setLabel2(label: label_displayPrice, text: "11000")
    
    
    btn_reserved.frame = CGRect(x: 0, y: 600, width: view.frame.width, height: 50)
    btn_reserved.setTitle("예매완료", for: .normal)
    btn_reserved.backgroundColor = .systemPink
    btn_reserved.titleLabel?.font = .boldSystemFont(ofSize: Font.titleSize)
    btn_reserved.titleLabel?.textColor = .white
    btn_reserved.titleLabel?.textAlignment = .center
    btn_reserved.addTarget(self, action: #selector(didTapReserved(_:)), for: .touchUpInside)
    view.addSubview(btn_reserved)
  }
  
  
  private func setNavigation() {
    navigationItem.title = "예매하기"
  }
  
  
  func setLabel(label: UILabel, text: String) {
    label.text = "\(text):   "
    view.addSubview(label)
    label.frame = CGRect(x: x, y: y, width: 120, height: 30)
    
    y += 40
  }
  
  func setLabel2(label: UILabel, text: String) {
    label.text = "\(text)"
    view.addSubview(label)
    label.frame = CGRect(x: x2, y: y2, width: 150, height: 30)
    
    y2 += 40
  }
  
  func setConstraints() {
    label_theater.translatesAutoresizingMaskIntoConstraints = false
    
    
    NSLayoutConstraint.activate([
      //      label_theater.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
      label_theater.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Size.largeMargin),
      label_theater.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.generalMargin),
      //      label_theater.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Size.generalMargin),
      
    ])
    
  }
  
  @objc func didTapReserved(_ sender: UIButton) {
    reservation = Reservation(
      theater: label_displayTheater.text!,
      screen: label_displayScreen.text!,
      title: label_displayTitle.text!,
      date: label_displayDate.text!,
      showTime: label_displayShowTime.text!,
      adultNumber: Int(label_displayAdultNumber.text!) ?? 1,
      price: label_displayPrice.text!
    )
    
    let movieVC = MovieViewController()
    navigationController?.popToRootViewController(animated: true)
  }
  
}
