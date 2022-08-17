//
//  WeatherModel.swift
//  weather-app-ios
//
//  Created by Prayag Gediya on 15/08/22.
//

import Foundation

struct WeatherList: Codable {
    let list: [WeatherModel]
}

struct WeatherModel: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Weather: Codable {
    let main: String
    let description: String
}

struct Main: Codable {
    let temp_min: Double
    let temp_max: Double
}
