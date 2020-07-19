//
//  AccountData.swift
//  harusari-woobin
//
//  Created by Woobin Cheon on 2020/07/18.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import Foundation
import UIKit

struct SpendingData {
    let spendingCategoryImage: String
    let spendingMoney: Int
    let spendingDetail: String
}
var spendingDataList = [SpendingData]()
var spendingDataInfo = [String : [SpendingData]]()

var moneyFromRoulette = 10000
var mileage = 0
var totalMoney = [String : Int]()
var selectedDate = ""

let imageNameArray = ["bag", "cart", "creditcard", "car", "tram.fill", "airplane", "keyboard", "tv"]
