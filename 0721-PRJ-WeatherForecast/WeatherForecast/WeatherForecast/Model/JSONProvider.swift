//
//  JSONProvider.swift
//  WeatherForecast
//
//  Created by Woobin Cheon on 2020/07/23.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

class JsonProvider {
    
    func getJson(from url: String) -> Data {
        let apiURL = URL(string: url)!
        var datata = Data()
        let dataTask = URLSession.shared.dataTask(with: apiURL) { data, response, error in
            guard error == nil else { return print(error!)} // error 검사
            guard let response = response as? HTTPURLResponse, // response 코드 검사
                (200..<400).contains(response.statusCode)
                else { return print("Invalid response")}
            guard let tempData = data else { return } // data 검사
            datata = tempData
            print(datata)
        }
        print(datata)
        dataTask.resume()
        return datata
    }
}
