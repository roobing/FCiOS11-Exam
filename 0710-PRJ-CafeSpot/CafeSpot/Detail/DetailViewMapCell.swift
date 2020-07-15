//
//  DetailViewMapCell.swift
//  CafeSpot
//
//  Created by Woobin Cheon on 2020/07/13.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit
import MapKit

class DetailViewMapCell: UITableViewCell {

    @IBOutlet var mapIconImageView: UIImageView!
    @IBOutlet var maptitleLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    func setLocation(with cafeinfo: CafeList) {

        if let address = cafeinfo.location["address"] as? String,
            let lat = cafeinfo.location["lat"] as? Double,
            let lng = cafeinfo.location["lng"] as? Double {
            let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let regionRadius: CLLocationDistance = 100
            let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            let point = MKPointAnnotation()
            point.title = cafeinfo.title
            point.coordinate = location
            mapView.setRegion(coordinateRegion, animated: true)
            mapView.addAnnotation(point)
            
        }
    
    }
    
}
