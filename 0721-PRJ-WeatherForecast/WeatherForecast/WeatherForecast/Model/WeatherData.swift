//
//  WeatherData.swift
//  WeatherForecast
//
//  Created by Woobin Cheon on 2020/07/22.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

struct CurrentWeatherData: Codable, Equatable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let dt: Double
    let sys: Sys
    let timezone: Double
    let id: Double
    let name: String
    let cod: Int
    
    struct Coord: Codable, Equatable {
        let lon: Double
        let lat: Double
    }
    
    struct Weather: Codable, Equatable  {
        let id: Double
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Codable, Equatable  {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Double
        let humidity: Double
    }
    
    struct Wind: Codable, Equatable  {
        let speed: Double
        let deg: Double
    }
    
    struct Clouds: Codable, Equatable  {
        let all: Double
    }
    
    struct Sys: Codable, Equatable  {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Double
        let sunset: Double
    }
    
    static func == (lhs: CurrentWeatherData, rhs: CurrentWeatherData) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
    
}
