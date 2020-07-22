//
//  WeatherProvider.swift
//  WeatherForecast
//
//  Created by Woobin Cheon on 2020/07/22.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

//        let url = "https://api.openweathermap.org/data/2.5/weather?q=london"
//        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
//        guard let weatherUrl = URL(string: encodedUrl) else { return }
//
//        let weatherData = URLSession.shared.dataTask(with: weatherUrl) { (data, response, error) in
//            guard error == nil else { return print(error!) }
//            guard let response = response as? HTTPURLResponse,
//                (200...400).contains(response.statusCode) else {
//                    return print("Invalid Code")
//            }
//            guard let data = data else { return }
//            print(data)
//
//        }
//        weatherData.resume()
