//
//  WeatherProvider.swift
//  WeatherForecast
//
//  Created by Woobin Cheon on 2020/07/22.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

class WeatherProvider {
    
    static var datata: CurrentWeatherData!
    
    static func getJson(from url: String, completionHandler: @escaping (Result<CurrentWeatherData, Error>) -> Void) {
        let apiURL = URL(string: url)!
        let dataTask = URLSession.shared.dataTask(with: apiURL) { data, response, error in
            guard error == nil else { return print(error!)} // error 검사
            guard let response = response as? HTTPURLResponse, // response 코드 검사
                (200..<400).contains(response.statusCode)
                else { return print("Invalid response")}
            guard let data = data else { return } // data 검사
            let decodedData = try! JSONDecoder().decode(CurrentWeatherData.self, from: data)
            datata = decodedData
            print("4")
            DispatchQueue.main.async {

                print("5")
                completionHandler(.success(datata))
            }
            print("7")
            
//            self.updateData(data)
//            print("Current Weather Data: \(data)")
        }
        
        print("6")
        dataTask.resume()
    }

}
