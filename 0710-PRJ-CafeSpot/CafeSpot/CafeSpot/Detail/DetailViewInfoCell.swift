//
//  DetailViewInfoCell.swift
//  CafeSpot
//
//  Created by Woobin Cheon on 2020/07/13.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit


class DetailViewInfoCell: UITableViewCell {
    
    @IBOutlet var infoIconImageView: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var naverButton: UIButton!
    @IBOutlet var instaButton: UIButton!
    
    var lat: CGFloat = 0
    var lng: CGFloat = 0
    var addr: String = ""
    var title: String = ""
    
    func transferLocation(with cafeInfo: CafeList) {
        if let tempLat = cafeInfo.location["lat"] as? CGFloat,
            let tempLng = cafeInfo.location["lng"] as? CGFloat,
            let tempAddr = cafeInfo.location["address"] as? String {
            lat = tempLat
            lng = tempLng
            addr = tempAddr
            title = cafeInfo.title
        } else {
            
        }
    }
    
    @IBAction func naverMapAction(_ sender: UIButton) {
        if let encodingAddr = addr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            print(encodingAddr)
            if let appURL = URL(string: "nmap://route/walk?dlat=\(lat)&dlng=\(lng)&dname=\(encodingAddr)&appname=kr.roobing.fastcampus") {
                if UIApplication.shared.canOpenURL(appURL) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    print("navr map trial has been failed")
                }
            }
        }
    }
    @IBAction func instaAction(_ sender: UIButton) {
        if let encodingTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            if let appURL = URL(string: "instagram://tag?name=\(encodingTitle)") {
                if UIApplication.shared.canOpenURL(appURL) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    print("instagram trial has been failed")
                }
            }
        }
    }
    
}
