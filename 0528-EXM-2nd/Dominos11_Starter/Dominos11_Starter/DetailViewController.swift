//
//  DetailViewController.swift
//  Dominos11_Starter
//
//  Created by Lee on 2020/05/26.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit


//var orderNumInfo = UserDefaults.standard

class DetailViewController: UIViewController {
  
    var itemCount: Int = 0
    var productName: String = ""
    
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var numOfItemLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupDetailView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Detail",itemCount)
        setupDetailView()
    }
    
    func setupDetailView() {
        detailImageView.image = UIImage(named: productName)
        guard let ad = UIApplication.shared.delegate as? AppDelegate else { return }
        numOfItemLabel.text = "\(ad.orderNumInfo[productName] ?? 0) 개"
    }
    @IBAction func plusItem(_ sender: UIButton) {
        guard let ad = UIApplication.shared.delegate as? AppDelegate else { return }
        itemCount += 1
        numOfItemLabel.text = "\(itemCount) 개"
        if ad.orderItemsList.contains(productName) {
            ad.orderNumInfo[productName] = itemCount
        }
        else {
            ad.orderItemsList.append(productName)
            ad.orderNumInfo[productName] = itemCount
        }
        
    }
    @IBAction func minusItem(_ sender: UIButton) {
        guard itemCount > 0 else { return }
        guard let ad = UIApplication.shared.delegate as? AppDelegate else { return }
        itemCount -= 1
        if itemCount == 0 {
            numOfItemLabel.text = "\(itemCount) 개"
            guard let index = ad.orderItemsList.firstIndex(of: productName) else { return }
            ad.orderItemsList.remove(at: index)
            ad.orderNumInfo[productName] = nil
        }
        else {
        numOfItemLabel.text = "\(itemCount) 개"
            ad.orderNumInfo[productName] = itemCount
        }
    }
    
    
}
