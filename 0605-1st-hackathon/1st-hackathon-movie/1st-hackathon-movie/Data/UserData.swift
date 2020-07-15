//
//  UserData.swift
//  1st-hackathon-movie
//
//  Created by Woobin Cheon on 2020/06/03.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import Foundation
import UIKit

struct BookingData {
    var bookingNum: Int?
    var userName: String?
    var movieName: String?
    var movieTime: String?
    var seatNum: String?
}

struct ReviewData {
    var rate: String?
    var image: UIImage?
    var userName: String?
    var title: String?
    var contents: String?
    var movieImage: UIImage?
}

class BookingInfo {
    static let shared = BookingInfo()
    
//    var bookingInfo: BookingData
    var bookingInfo: BookingData = BookingData(bookingNum: nil, userName: nil, movieName: nil, movieTime: nil, seatNum: nil)
    
    init() {}
}

struct Reservation {
  var theater: String
  var screen: String

  var title: String
  var date: String
  var showTime: String

  var adultNumber: Int
//  var youthNumber: Int

//  var seat: [String]
  var price: String
}

var reservation: Reservation?

class ReviewInfo {
    static let shared = ReviewInfo()
    
    var reviewIndex: Int = 0
    var reviewInfo: [ReviewData] = []
    
    init() {}
}

struct Size {
  static let tinyMargin: CGFloat = 5
  static let smallMargin: CGFloat = 10
  static let generalMargin: CGFloat = 20
  static let largeMargin: CGFloat = 30

  static let posterHeight: CGFloat = 100
  static let cellHeight: CGFloat = 120

  static let titleHeight: CGFloat = 30
  static let textHeight: CGFloat = 20
}

struct Font {
  static let titleSize: CGFloat = 16
  static let subTextSize: CGFloat = 12
}
