//
//  DataService.swift
//  weather-app-ios
//
//  Created by Prayag Gediya on 15/08/22.
//

import Foundation
import Combine

protocol Service {
    func getWeatherData(lat: Double, long: Double) -> AnyPublisher<WeatherList, Error>
}

class DataService: Service {
    private let baseUrl: String = "https://api.openweathermap.org/data/2.5/"
    private let apiKey: String = "2783803ef79370d3892f0da6bb6d4239"

    func getWeatherData(lat: Double, long: Double) -> AnyPublisher<WeatherList, Error> {
        let urlString: String = baseUrl + "find?" + "lat=\(lat)&lon=\(long)&appid=\(apiKey)&units=metric"

        return URLSession.shared.dataTaskPublisher(for: URL(string: urlString)!)
            .map({
                return $0.data
            })
            .decode(type: WeatherList.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}

class MockService: Service {
    let tests: WeatherList = .init(list: [.init(name: "San Francisco", weather: [Weather(main: "Rain", description: "Rainy")], main: .init(temp_min: 245.05, temp_max: 245.05))])

    func getWeatherData(lat: Double, long: Double) -> AnyPublisher<WeatherList, Error> {
        Just(tests)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
}
