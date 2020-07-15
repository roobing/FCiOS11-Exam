//
//  LocalizeMethods.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 7/1/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//
import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
}

