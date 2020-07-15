//
//  TestViewController.swift
//  CafeSpot
//
//  Created by Woobin Cheon on 2020/07/13.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var testTableView: UITableView!
    
    var cafeInfo = CafeList(title: "", description: "", location: ["": ""], isFavorite: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = cafeInfo.title

    }
    
    
}
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            if let customCell = tableView.dequeueReusableCell(withIdentifier: "DetailViewImageCell", for: indexPath) as? DetailViewImageCell {
                customCell.setImage(with: cafeInfo)
                cell = customCell
            }
        case 2:
            if let customCell = tableView.dequeueReusableCell(withIdentifier: "DetailViewMapCell", for: indexPath) as? DetailViewMapCell {
                customCell.setLocation(with: cafeInfo)
                cell = customCell
            }
        case 4:
            if let customCell = tableView.dequeueReusableCell(withIdentifier: "DetailViewInfoCell", for: indexPath) as? DetailViewInfoCell {
                
                customCell.naverButton.layer.borderColor = UIColor.gray.cgColor
                customCell.naverButton.layer.borderWidth = 1
                customCell.naverButton.layer.cornerRadius = 8
                
                customCell.instaButton.layer.borderColor = UIColor.gray.cgColor
                customCell.instaButton.layer.borderWidth = 1
                customCell.instaButton.layer.cornerRadius = 8
                
                customCell.transferLocation(with: cafeInfo)
                
                cell = customCell
                
            }
        case 1, 3:
            if let customCell = tableView.dequeueReusableCell(withIdentifier: "DetailViewDividerCell", for: indexPath) as? DetailViewDividerCell {
                cell = customCell
            }
        default:
            break
        }
        return cell
    }
}
