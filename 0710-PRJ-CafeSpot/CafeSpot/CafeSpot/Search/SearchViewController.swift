//
//  SearchViewController.swift
//  CafeSpot
//
//  Created by Woobin Cheon on 2020/07/13.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {
    
    @IBOutlet var collectionDownConst: NSLayoutConstraint!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var collectionViewHideButton: UIButton!
    @IBOutlet var SearchViewCollectionView: UICollectionView!
    
    var cafeList = [CafeList]()
    var annoCafeList = [CafeList]()
    var numOfAnno = 0
    var isHidden = false
    var annoSelectionFlag = false
    var mapRectangle: MKMapRect = MKMapRect(x: 0, y: 0, width: 100, height: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("===========[ SearchView Did Load ]==========\n")
        collectionViewHideButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionViewHideButton.layer.cornerRadius = 20
        mapView.delegate = self
        cafeList = jsonToStruct(jsonFileName: "CafeList")
        setLocations(with: cafeList)
        
        
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
    
    func setLocations(with cafeInfo: [CafeList]) {
        for cafe in cafeInfo {
            if let address = cafe.location["address"] as? String,
                let lat = cafe.location["lat"] as? Double,
                let lng = cafe.location["lng"] as? Double {
                let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                let regionRadius: CLLocationDistance = 2000
                let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
                let point = MKPointAnnotation()
                point.coordinate = location
                point.title = cafe.title
                mapView.setRegion(coordinateRegion, animated: true)
                mapView.addAnnotation(point)
            }
        }
    }
    @IBAction func hideButtonAction(_ sender: UIButton) {
        if !isHidden {
            UIView.animate(withDuration: 0.5, animations: {
            self.collectionDownConst.priority = UILayoutPriority(1000)
            self.view.layoutIfNeeded()
        })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionDownConst.priority = UILayoutPriority(998)
                self.view.layoutIfNeeded()
            })
        }
        isHidden.toggle()
    }
    
}
extension SearchViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("===========[ didSelect ]==========\n")
        annoCafeList.removeAll()
        annoSelectionFlag = true
        if isHidden {
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionDownConst.priority = UILayoutPriority(998)
                self.view.layoutIfNeeded()
                self.isHidden.toggle()
            })
        } else {
            // do nothing
        }
        
        for cafe in cafeList {
            guard let lat = cafe.location["lat"] as? Double else { return }
            for anno in mapView.selectedAnnotations{
                if lat == anno.coordinate.latitude {
                    annoCafeList.append(cafe)
                } else {
                    // do nothing
                }
            }
        }
        print(annoCafeList)
        SearchViewCollectionView.reloadData()
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("===========[ didDeselect ]==========\n")
        annoCafeList.removeAll()
        let annoSets = mapView.annotations(in: mapView.visibleMapRect)
        for annoSet in annoSets {
            if let annotation = annoSet as? MKPointAnnotation {
                for cafe in cafeList {
                    guard let lat = cafe.location["lat"] as? Double else { return }
                    if lat == annotation.coordinate.latitude {
                        annoCafeList.append(cafe)
                    } else {
                        // do nothing
                    }
                }
            } else {
                print("annoSets Type Casting has been failed")
            }
        }
        annoSelectionFlag.toggle()
        SearchViewCollectionView.reloadData()
        
    }
    
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
//        print("==================[ mapViewWillStartLoadingMap ]=================\n")
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
//        print("==================[ mapViewDidFinishLoadingMap ]=================\n")
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        print("===========[ regionDidChangeAnimated ]==========\n")
        if !annoSelectionFlag {
            annoCafeList.removeAll()
            let annoSets = mapView.annotations(in: mapView.visibleMapRect)
            for annoSet in annoSets {
                if let annotation = annoSet as? MKPointAnnotation {
                    for cafe in cafeList {
                        guard let lat = cafe.location["lat"] as? Double else { return }
                        if lat == annotation.coordinate.latitude {
                            annoCafeList.append(cafe)
                        } else {
                            // do nothing
                        }
                    }
                } else {
                    print("annoSets Type Casting has been failed")
                }
            }
        } else {
            // do nothing
        }
        if !isHidden {
            SearchViewCollectionView.reloadData()
        } else {
            // do noting
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(annoCafeList.count)
        return annoCafeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchViewCollectionCell", for: indexPath) as? SearchViewCollectionCell else { return UICollectionViewCell()}
            cell.setAnnotationCell(with: annoCafeList[indexPath.item])
        return cell
    }
    
    
}
