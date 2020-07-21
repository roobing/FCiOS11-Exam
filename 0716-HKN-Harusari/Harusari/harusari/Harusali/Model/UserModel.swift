//
// UserModel.swift
//  Harusali
//
//  Created by 김믿음 on 2020/07/16.
//  Copyright © 2020 김믿음. All rights reserved.
//

import Foundation
import UIKit

struct UserModel {
    let email: String
    let name: String
    let balance : Int
    let checkSetBalance: String
}

struct UserReference {
    static let email = "Email"
    static let name = "Name"
    static let balance = "Balance"
    static let checkSetBalance = "checkSetBalance"
}


struct SpendingData {
    let spendingCategoryImage: String
    let spendingMoney: Int
    let spendingDetail: String
}
var spendingDataList = [SpendingData]()
var spendingDataInfo = [String : [SpendingData]]()

var moneyFromRoulette = UserDefaults.standard.string(forKey: UserReference.balance)
var mileage = 0
var totalMoney = [String : Int]()
var selectedDate = ""

let imageNameArray = ["fork", "cafe", "beer", "fashion", "transportation", "gift", "ticket", "more"]

