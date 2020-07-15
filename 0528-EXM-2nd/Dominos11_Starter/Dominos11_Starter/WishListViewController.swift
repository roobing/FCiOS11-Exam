//
//  WishListViewController.swift
//  Dominos11_Starter
//
//  Created by Lee on 2020/05/26.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class WishListViewController: UIViewController {

    let wishListTable: UITableView = UITableView()
    var itemList: [String] = []
    var totalPrice: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWishListTable()
    }
    
    func setupWishListTable() {
        wishListTable.frame = view.frame
        wishListTable.rowHeight = 100
        wishListTable.dataSource = self
        wishListTable.delegate = self
        view.addSubview(wishListTable)
    }
    
    func resetList() {
        guard let ad = UIApplication.shared.delegate as? AppDelegate else { return }
        ad.orderItemsList.removeAll()
        ad.orderNumInfo.removeAll()
        itemList.removeAll()
//        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC")
        wishListTable.reloadData()
    }
    
    // 주문버튼
    @IBAction func orderButton(_ sender: UIBarButtonItem) {
        guard let ad = UIApplication.shared.delegate as? AppDelegate else { return }
        var summary: String = ""
        for i in 0...ad.orderItemsList.count-1 {
            summary = summary + "\(ad.orderItemsList[i]) - \(ad.orderNumInfo[ad.orderItemsList[i]] ?? 0)개\n"
        }
        summary = summary + "결제금액: 100,000원"
        let orderAlert = UIAlertController(title: "결제내역", message: summary, preferredStyle: .alert)
        let payAction = UIAlertAction(title: "결제하기", style: .default, handler: { (_) in
            self.resetList()
        })
        let backAction = UIAlertAction(title: "돌아가기", style: .cancel)
        orderAlert.addAction(payAction)
        orderAlert.addAction(backAction)
        
        present(orderAlert, animated: true)
    }
    
    @IBAction func resetButton(_ sender: UIBarButtonItem) {
//        guard let ad = UIApplication.shared.delegate as? AppDelegate else { return }
//        ad.orderItemsList.removeAll()
//        ad.orderNumInfo.removeAll()
//        itemList.removeAll()
//        wishListTable.reloadData()
        resetList()
    }
    
    
//    func totalPriceCal() {
//        guard let ad = UIApplication.shared.delegate as? AppDelegate else { return }
//        if ad.orderItemsList.contains()
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let ad = UIApplication.shared.delegate as? AppDelegate else { return }
        itemList = ad.orderItemsList
//        totalPrice =
        wishListTable.reloadData()
    }
}

extension WishListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "WishListCell")
        guard let ad = UIApplication.shared.delegate as? AppDelegate else { return cell}
        cell.imageView?.image = UIImage(named: itemList[indexPath.row])
        cell.textLabel?.text = itemList[indexPath.row]
        cell.detailTextLabel?.text = "주문수량: \(ad.orderNumInfo[itemList[indexPath.row]] ?? 0)개"
        return cell
    }
}

extension WishListViewController: UITableViewDelegate {
}
