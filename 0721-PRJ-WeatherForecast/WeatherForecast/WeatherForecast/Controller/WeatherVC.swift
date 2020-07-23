//
//  WeatherVC.swift
//  WeatherForecast
//
//  Created by Woobin Cheon on 2020/07/22.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {
    
    let backImage = UIImageView()
    let reloadButton = UIBarButtonItem()
    let topInfoView = TopInfoView()
    let scrolledInfoView = ScrolledInfoView()
    let backScrollView = UIScrollView()
    var currentWeatherData: CurrentWeatherData?
    var test = 0
    
//    let weatherProvider = WeatherProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraint()
        getJson(from: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=ffddca810f60a187f1bcd04e58f33d0e")
//        weatherProvider.getJson(from: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=ffddca810f60a187f1bcd04e58f33d0e")
        print(currentWeatherData?.main)
        print(test)
        
    }
        func getJson(from url: String) {
            let apiURL = URL(string: url)!
            let dataTask = URLSession.shared.dataTask(with: apiURL) { data, response, error in
                guard error == nil else { return print(error!)} // error 검사
                guard let response = response as? HTTPURLResponse, // response 코드 검사
                    (200..<400).contains(response.statusCode)
                    else { return print("Invalid response")}
                guard let data = data else { return } // data 검사
//                self.data.append(data)
//                print("Current Weather Data: \(self.data)")
                self.test = 1
                self.currentWeatherData = try! JSONDecoder().decode(CurrentWeatherData.self, from: data)
                print(self.currentWeatherData?.main)
            }
            dataTask.resume()
        }
    
    func setupUI() {
        backImage.image = UIImage(named: "sunny")
        
        navigationItem.titleView = topInfoView
        
        let reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(weatherInfoReload(_:)))
        navigationItem.rightBarButtonItem = reloadButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
    }
    
    func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        [backImage, backScrollView].forEach({
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        backScrollView.addSubview(scrolledInfoView)
        scrolledInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backImage.topAnchor.constraint(equalTo: view.topAnchor),
            backImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backScrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            backScrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            backScrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            backScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrolledInfoView.topAnchor.constraint(equalTo: backScrollView.contentLayoutGuide.topAnchor),
            scrolledInfoView.leadingAnchor.constraint(equalTo: backScrollView.contentLayoutGuide.leadingAnchor),
            scrolledInfoView.trailingAnchor.constraint(equalTo: backScrollView.contentLayoutGuide.trailingAnchor),
            scrolledInfoView.bottomAnchor.constraint(equalTo: backScrollView.contentLayoutGuide.bottomAnchor),
            scrolledInfoView.widthAnchor.constraint(equalTo: backScrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    // MARK: - Selector
    @objc func weatherInfoReload(_ sender: UIBarButtonItem) {
        print("Weahter Info Reload...")
    }
    
}
