//
//  DataViewModel.swift
//  weather-app-ios
//
//  Created by Prayag Gediya on 15/08/22.
//

import SwiftUI
import Combine

class DataViewModel: ObservableObject {

    @UserDefault("weatherData", defaultValue: nil)
    var weatherData: WeatherList? {
        didSet { self.objectWillChange.send() }
    }

    let service: Service
    var cancellables = Set<AnyCancellable>()

    init(service: Service) {
        self.service = service
    }

    func fetchData(lat: Double, long: Double) {
        service.getWeatherData(lat: lat, long: long)
            .sink { data in
                switch data {
                case .finished:
                    print("Got the data!")
                case .failure(let error) :
                    print("Error on API call - ", error.localizedDescription)
                }
            } receiveValue: { [weak self] weatherData in
                self?.weatherData = weatherData
            }.store(in: &cancellables)
    }

}
