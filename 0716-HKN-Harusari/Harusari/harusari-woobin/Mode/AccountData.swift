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

var totalMoney = 10000

var spendingDataInfo = [String : [SpendingData]]()

var todayDate = ""
var selectedDate = ""

