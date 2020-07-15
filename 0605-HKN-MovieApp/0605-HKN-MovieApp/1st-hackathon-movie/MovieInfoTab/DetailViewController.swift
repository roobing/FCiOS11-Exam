//
//  DetailViewController.swift
//  MovieTheater
//
//  Created by 박종덕 on 2020/06/05.
//  Copyright © 2020 example. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  var movie: Movie! = nil
  
  let img_poster = UIImageView()
  
  let container_title = UIView()
  let label_title = UILabel()
  let label_subtitle = UILabel()
  //  let label_viewingRating = UILabel()   //image
  
  let container_info = UIView()
  let label_genre = UILabel()
  let label_runningTime = UILabel()
  let label_releaseDate = UILabel()
  
  let label_synopsis = UILabel()
  
  let btn_reserve = UIButton()
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    
    // Do any additional setup after loading the view.
    
    setLayout()
    setConstraints()
  }
  
  private func setNavigation() {
    navigationItem.title = "영화 상세"
  }
  
  
  func setLayout() {
    img_poster.image = UIImage(named: movie.poster)
    
    label_title.text = "\(movie.title)"
    label_title.font = .boldSystemFont(ofSize: Font.titleSize)
    
    label_subtitle.text = "\(movie.subtitle)"
    label_subtitle.font = .systemFont(ofSize: Font.subTextSize)
    label_subtitle.textColor = .gray
    
    label_genre.text = "\(movie.genre)"
    label_genre.font = .systemFont(ofSize: Font.subTextSize)
    
    label_runningTime.text = "/   \(movie.runningTime)"
    label_runningTime.font = .systemFont(ofSize: Font.subTextSize)
    
    label_releaseDate.text = "\(movie.releaseDate)"
    label_releaseDate.font = .systemFont(ofSize: Font.subTextSize)
    
//    img_poster.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
//    container_title.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//    container_info.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    btn_reserve.setTitle("예매하기", for: .normal)
    btn_reserve.titleLabel?.font = .boldSystemFont(ofSize: Font.titleSize)
    btn_reserve.titleLabel?.textColor = .black
    btn_reserve.titleLabel?.textAlignment = .center
    btn_reserve.backgroundColor = .systemPink
//    btn_reserve.tintColor = .blue
    
    btn_reserve.addTarget(self, action: #selector(didTapReserve(_:)), for: .touchUpInside)
    
    
    
    img_poster.contentMode = .scaleToFill
//    container_title.backgroundColor = .green
//    container_info.backgroundColor = .yellow
    
    
    
    
    
    view.addSubview(img_poster)
    
    view.addSubview(container_title)
    container_title.addSubview(label_title)
    container_title.addSubview(label_subtitle)
    
    view.addSubview(container_info)
    container_info.addSubview(label_genre)
    container_info.addSubview(label_runningTime)
    container_info.addSubview(label_releaseDate)
    
    view.addSubview(btn_reserve)
  }
  
  func setConstraints() {
    img_poster.translatesAutoresizingMaskIntoConstraints = false
    
    container_title.translatesAutoresizingMaskIntoConstraints = false
    label_title.translatesAutoresizingMaskIntoConstraints = false
    label_subtitle.translatesAutoresizingMaskIntoConstraints = false
    
    container_info.translatesAutoresizingMaskIntoConstraints = false
    label_genre.translatesAutoresizingMaskIntoConstraints = false
    label_runningTime.translatesAutoresizingMaskIntoConstraints = false
    label_releaseDate.translatesAutoresizingMaskIntoConstraints = false
    
    btn_reserve.translatesAutoresizingMaskIntoConstraints = false
    
    
    NSLayoutConstraint.activate([
      //height 지정 필요
      img_poster.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
      
      img_poster.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
//      img_poster.bottomAnchor.constraint(equalTo: container_title.topAnchor, constant: -Size.generalMargin),
      img_poster.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
      img_poster.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
      
      
      
      container_title.heightAnchor.constraint(equalTo: label_title.heightAnchor, constant: label_subtitle.frame.height + 30),
      container_title.topAnchor.constraint(equalTo: img_poster.bottomAnchor, constant: Size.generalMargin),
//      container_title.bottomAnchor.constraint(equalTo: container_info.topAnchor, constant: -Size.generalMargin),
      container_title.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
      container_title.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
//
      label_title.topAnchor.constraint(equalTo: container_title.topAnchor, constant: Size.smallMargin),
//      label_title.bottomAnchor.constraint(equalTo: label_subtitle.topAnchor, constant: -Size.smallMargin),
      label_title.leadingAnchor.constraint(equalTo: container_title.leadingAnchor, constant: Size.smallMargin),
      label_title.trailingAnchor.constraint(equalTo: container_title.trailingAnchor, constant: -Size.smallMargin),

      label_subtitle.topAnchor.constraint(equalTo: label_title.bottomAnchor, constant: Size.tinyMargin),
      //      label_subtitle.bottomAnchor.constraint(equalTo: container_title.bottomAnchor, constant: -Size.smallMargin),
      label_subtitle.leadingAnchor.constraint(equalTo: container_title.leadingAnchor, constant: Size.smallMargin),
      label_subtitle.trailingAnchor.constraint(equalTo: container_title.trailingAnchor, constant: -Size.smallMargin),
      
      
      
      
      container_info.heightAnchor.constraint(equalTo: label_genre.heightAnchor, constant: label_releaseDate.frame.height + 40),
      container_info.topAnchor.constraint(equalTo: container_title.bottomAnchor, constant: Size.generalMargin),
      container_info.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
      container_info.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),

      label_genre.topAnchor.constraint(equalTo: container_info.topAnchor, constant: Size.smallMargin),
      label_genre.leadingAnchor.constraint(equalTo: container_info.leadingAnchor, constant: Size.smallMargin),
//      label_genre.trailingAnchor.constraint(equalTo: label_runningTime.leadingAnchor, constant: -Size.smallMargin),

      label_runningTime.topAnchor.constraint(equalTo: container_info.topAnchor, constant: Size.smallMargin),
      label_runningTime.leadingAnchor.constraint(equalTo: label_genre.trailingAnchor, constant: Size.smallMargin),
//      label_runningTime.trailingAnchor.constraint(equalTo: container_info.trailingAnchor, constant: -Size.smallMargin),
      

//      label_releaseDate.bottomAnchor.constraint(equalTo: container_info.bottomAnchor, constant: -Size.smallMargin),
      label_releaseDate.topAnchor.constraint(equalTo: label_genre.bottomAnchor, constant: Size.smallMargin),
      label_releaseDate.leadingAnchor.constraint(equalTo: container_info.leadingAnchor, constant: Size.smallMargin),
//      label_releaseDate.trailingAnchor.constraint(equalTo: container_info.trailingAnchor, constant: -Size.smallMargin),
      
      
      
      btn_reserve.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Size.largeMargin),
      //width, height
      btn_reserve.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: 10),
      btn_reserve.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
    ])
    
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
  @objc func didTapReserve(_ sender: UIButton) {
    let choiceVC = ChoiceViewController()
    choiceVC.movie = self.movie
    choiceVC.view.backgroundColor = .systemBackground
    navigationController?.pushViewController(choiceVC, animated: true)
    
    
//            let bookingVC = BookingViewController()
////            bookingVC.movieIndex = movieIndex
//            navigationController?.pushViewController(bookingVC, animated: true)
  }
  
}
