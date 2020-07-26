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
    var backImageTrailingConstraint: NSLayoutConstraint!
    let reloadButton = UIBarButtonItem()
    let topInfoView = TopInfoView()
    let scrolledInfoView = ScrolledInfoView()
    let backScrollView = UIScrollView()
    var currentWeatherData: CurrentWeatherData?
    var test = 0
    
    let weatherProvider = WeatherProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraint()
//        weatherProvider.getJson(from: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=ffddca810f60a187f1bcd04e58f33d0e")
//        WeatherProvider.getJson(from: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=ffddca810f60a187f1bcd04e58f33d0e") { result in
//            if let data = try? result.get() {
//                self.currentWeatherData = data
//                print("1")
//            }
//
//            print("2")
//        }
        print("3")
        
        
    }
    
    func setupUI() {
        backImage.image = UIImage(named: "sunny")
        
        navigationItem.titleView = topInfoView
        
        let reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(weatherInfoReload(_:)))
        navigationItem.rightBarButtonItem = reloadButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        backScrollView.delegate = self
        
        
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
        let apiURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=ffddca810f60a187f1bcd04e58f33d0e")!
        let dataTask = URLSession.shared.dataTask(with: apiURL) { data, response, error in
            guard error == nil else { return print(error!)} // error 검사
            guard let response = response as? HTTPURLResponse, // response 코드 검사
                (200..<400).contains(response.statusCode)
                else { return print("Invalid response")}
            guard let data = data else { return } // data 검사
            let decodedData = try! JSONDecoder().decode(CurrentWeatherData.self, from: data)
            self.currentWeatherData = decodedData
        }
        dataTask.resume()
    }
    
}

extension WeatherVC: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        backImageTrailingConstraint = backImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        backImageTrailingConstraint.constant = 10
        view.layoutIfNeeded()
        print(scrollView.contentOffset.y)
    }
}
