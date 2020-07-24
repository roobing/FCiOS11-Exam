//
//  WeatherProvider.swift
//  WeatherForecast
//
//  Created by Woobin Cheon on 2020/07/22.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

class WeatherProvider {
    
    var currentWeatherData: [CurrentWeatherData] = []

    func getJson(from url: String) {
        let apiURL = URL(string: url)!
        let dataTask = URLSession.shared.dataTask(with: apiURL) { data, response, error in
            guard error == nil else { return print(error!)} // error 검사
            guard let response = response as? HTTPURLResponse, // response 코드 검사
                (200..<400).contains(response.statusCode)
                else { return print("Invalid response")}
            guard let data = data else { return } // data 검사
            self.updateData(data)
            print(self.currentWeatherData[0])
            print("Current Weather Data: \(data)")
        }
        dataTask.resume()
    }
    
    
    func updateData(_ data: Data) {

        let decodedData = try! JSONDecoder().decode(CurrentWeatherData.self, from: data)
        self.currentWeatherData.append(decodedData)
        
    }
}
