//
//  CategoryViewController.swift
//  Dominos11_Starter
//
//  Created by Lee on 2020/05/26.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    let categoryListTable: UITableView = UITableView()
    @IBOutlet var logoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCategoryListTable()
        
    }
    
    func setupCategoryListTable() {
        categoryListTable.frame = view.frame
        categoryListTable.rowHeight = 100
        categoryListTable.dataSource = self
        categoryListTable.delegate = self

        let imageHeader = UIImageView(frame: CGRect(x: 87, y: 0, width: 220, height: 220))
        imageHeader.image = UIImage(named: "logo")
        
        logoView.addSubview(imageHeader)
        categoryListTable.tableHeaderView = logoView
        
        view.addSubview(categoryListTable)
        
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ad = UIApplication.shared.delegate as? AppDelegate else { return 0}
        return ad.categoryListImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        cell = UITableViewCell(style: .default, reuseIdentifier: "CategoryCell")
        guard let ad = UIApplication.shared.delegate as? AppDelegate else {return cell}
        cell.imageView?.image = UIImage(named: ad.categoryListImages[indexPath.row])
        return cell
    }
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let productVC = storyboard?.instantiateViewController(withIdentifier: "ProductVC") as? ProductViewController else { return }
        guard let ad = UIApplication.shared.delegate as? AppDelegate else {return}
        productVC.productFromCategory = ad.categoryListImages[indexPath.row]
        productVC.title = ad.categoryListImages[indexPath.row]
        navigationController?.pushViewController(productVC, animated: true)
        
    }
    
}
