//
//  ViewController.swift
//  CafeSpot
//
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit



final class HomeViewController: UIViewController, UISearchResultsUpdating {
    
  
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var HomeCollectionView: UICollectionView!
    
    var cafeList = [CafeList]()
    var searchKeyword = ""
    var searchCafeList = [CafeList]()
    var searchingFlag = false
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cafeList = jsonToStruct(jsonFileName: "CafeList")
//        configureSearchController()
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "검색..."

        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
    
    func setupSearchBar() {
        
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        print("\(sender.tag) has been tapped!")
        
        cafeList[sender.tag].isFavorite = !cafeList[sender.tag].isFavorite
        HomeCollectionView.reloadData()
    }
    
    func jsonToStruct(jsonFileName filename: String) -> [CafeList] {
        guard let cafeListFile = Bundle.main.url(forResource: filename, withExtension: "json") else { fatalError("json file loading failure") }
        guard let data = try? Data(contentsOf: cafeListFile) else { fatalError("json data laoding failure") }
        var list = [CafeList]()
        do {
            if let cafeJson = try JSONSerialization.jsonObject(with: data) as? [[String : Any]] {
                for cafe in cafeJson {
                    if let title = cafe["title"] as? String,
                        let description = cafe["description"] as? String,
                        let isFavorite = cafe["isFavorite"] as? Bool,
                        let location  = cafe["location"] as? [String: Any] {
                        let eachCafe = CafeList(title: title, description: description, location: location, isFavorite: isFavorite)
                        list.append(eachCafe)
                    }
                }
            }
        } catch {
            
        }
        return list
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        print("end editing")
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchingFlag {
            return searchCafeList.count
        } else {
            return cafeList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CafeListCell", for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell()}
        if searchingFlag {
            cell.cellConfig(cafeImage: searchCafeList[indexPath.item].title, cafeName: searchCafeList[indexPath.item].title, cafeDescription: searchCafeList[indexPath.item].description, isFavorite: searchCafeList[indexPath.item].isFavorite, indexPath: indexPath)
        } else {
            cell.cellConfig(cafeImage: cafeList[indexPath.item].title, cafeName: cafeList[indexPath.item].title, cafeDescription: cafeList[indexPath.item].description, isFavorite: cafeList[indexPath.item].isFavorite, indexPath: indexPath)
        }
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        vc.cafeInfo = cafeList[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
        searchingFlag = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searching has been canceled")
        searchBar.text = nil
        view.endEditing(true)
        HomeCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !(searchBar.text?.isEmpty ?? false) {
            searchingFlag = true
            searchCafeList.removeAll()
            searchKeyword = searchBar.text ?? ""
            for cafe in cafeList {
                if cafe.title.contains(searchKeyword) {
                    print(searchKeyword)
                    searchCafeList.append(cafe)
                    print(searchCafeList.count)
                } else {
                    // do nothing
                }
            }
        } else {
            print("Empty")
            searchCafeList.removeAll()
            searchingFlag = false
        }
        HomeCollectionView.reloadData()
    }
}
