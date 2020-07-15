//
//  MovieListCell.swift
//  MovieTheater
//
//  Created by 박종덕 on 2020/06/04.
//  Copyright © 2020 example. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {
  /*
   제목
   장르
   러닝타임
   */
  let img_poster = UIImageView()
  
  let label_reservationRate = UILabel()
  let label_title = UILabel()
  let label_genre = UILabel()
  let label_runningTime = UILabel()
  let label_releaseDate = UILabel()
  
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    // 커스텀 뷰를 올릴 때는 contentView 위에 추가
    setupImageView(imageView: img_poster)
    setupSubview(view: label_reservationRate)
    setupSubview(view: label_title)
    setupSubview(view: label_genre)
    setupSubview(view: label_runningTime)
    setupSubview(view: label_releaseDate)
  }
  
  func setupSubview(view: UILabel) {
    view.textColor = .black
    view.backgroundColor = .clear
    contentView.addSubview(view)
  }
  
  func setupImageView(imageView: UIImageView) {
    contentView.addSubview(imageView)
  }
  
  // 스토리보드 생성할 때
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // 레이아웃 조정 시
  override func layoutSubviews() {
    super.layoutSubviews()
    
    //    myLabel.frame = CGRect(
    //      x: frame.width - 120, y: 15,
    //      width: 100, height: frame.height - 30
    //    )
  }
  
}
