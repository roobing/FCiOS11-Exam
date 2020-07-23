//
//  WeatherProvider.swift
//  WeatherForecast
//
//  Created by Woobin Cheon on 2020/07/22.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

class WeatherProvider {
//    var data: Data
//    let url: String
//    lazy var currentWeatherData = try! JSONDecoder().decode(CurrentWeatherData.self, from: self.data)
//    
//    init(_ url: String) {
//        self.url = url
//        let apiURL = URL(string: self.url)!
//        let dataTask = URLSession.shared.dataTask(with: apiURL) { data, response, error in
//            guard error == nil else { return print(error!)} // error 검사
//            guard let response = response as? HTTPURLResponse, // response 코드 검사
//                (200..<400).contains(response.statusCode)
//                else { return print("Invalid response")}
//            guard let data = data else { return } // data 검사
//            self.data.append(data)
//            print("Current Weather Data: \(self.data)")
//            let currentWeatherData = try! JSONDecoder().decode(CurrentWeatherData.self, from: data)
//            print(currentWeatherData.main)
//        }
//        dataTask.resume()
//    }
//    func getJson(from url: String) {
//        let apiURL = URL(string: url)!
//        let dataTask = URLSession.shared.dataTask(with: apiURL) { data, response, error in
//            guard error == nil else { return print(error!)} // error 검사
//            guard let response = response as? HTTPURLResponse, // response 코드 검사
//                (200..<400).contains(response.statusCode)
//                else { return print("Invalid response")}
//            guard let data = data else { return } // data 검사
//            self.data.append(data)
//            print("Current Weather Data: \(self.data)")
//            let currentWeatherData = try! JSONDecoder().decode(CurrentWeatherData.self, from: data)
//            print(currentWeatherData.main)
//        }
//        dataTask.resume()
//    }
}
