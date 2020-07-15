//
//  ProductViewController.swift
//  Dominos11_Starter
//
//  Created by Lee on 2020/05/26.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
  
    let productListTable: UITableView = UITableView()
    let productPrice: [Int] = []
    var productFromCategory: String = ""
      
      override func viewDidLoad() {
          super.viewDidLoad()
          setupProductListTable()
          
      }
      
      func setupProductListTable() {
          productListTable.frame = view.frame
          productListTable.rowHeight = 120
          productListTable.dataSource = self
          productListTable.delegate = self
          view.addSubview(productListTable)
          
      }
  }

  extension ProductViewController: UITableViewDataSource {
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ad = UIApplication.shared.delegate as? AppDelegate else { return 0}
        return ad.productListImages[productFromCategory]!.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell: UITableViewCell
          cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ProductCell")
          guard let ad = UIApplication.shared.delegate as? AppDelegate else { return cell}
        cell.imageView?.image = UIImage(named: ad.productListImages[productFromCategory]![indexPath.row])
        cell.textLabel?.text = ad.productListImages[productFromCategory]![indexPath.row]
        switch productFromCategory {
        case "사이드디시":
            cell.detailTextLabel?.text = "7000원"
        case "음료":
            cell.detailTextLabel?.text = "3000원"
        case "피클소스":
            cell.detailTextLabel?.text = "500원"
        default:
            cell.detailTextLabel?.text = "10000원"
        }
          return cell
      }
  }

  extension ProductViewController: UITableViewDelegate {
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else { return }
        
        guard let ad = UIApplication.shared.delegate as? AppDelegate else { return }
        detailVC.title = ad.productListImages[productFromCategory]![indexPath.row]
        detailVC.productName = ad.productListImages[productFromCategory]![indexPath.row]
          navigationController?.pushViewController(detailVC, animated: true)
          
      }
      
  }
