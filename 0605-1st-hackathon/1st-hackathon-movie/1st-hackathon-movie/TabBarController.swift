//
//  TabBarController.swift
//  1st-hackathon-movie
//
//  Created by Woobin Cheon on 2020/06/03.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTapBatItems()

    }
    
    func setTapBatItems() {
//        let movieInfoTapVC = UINavigationController(rootViewController: MovieInfoTapViewController())
        let movieInfoTapVC = UINavigationController(rootViewController: MovieViewController())
        let bookingInfoTapVC = BookingInfoTapViewController()
        let reviewTapVC = UINavigationController(rootViewController: ReviewTapViewController())
        
        movieInfoTapVC.tabBarItem = UITabBarItem(title: "영화", image: .none, tag: 0)
        bookingInfoTapVC.tabBarItem = UITabBarItem(title: "예매내역", image: .none, tag: 0)
        reviewTapVC.tabBarItem = UITabBarItem(title: "후기", image: .none, tag: 0)
        
        viewControllers = [movieInfoTapVC, bookingInfoTapVC, reviewTapVC]
    }

}
