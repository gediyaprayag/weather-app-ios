//
//  LocationViewModel.swift
//  weather-app-ios
//
//  Created by Prayag Gediya on 15/08/22.
//

import SwiftUI
import CoreLocation

class LocationViewModel: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var lat: Double? = nil
    @Published var long: Double? = nil

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestLocation()
        self.requestAuthorisation()
    }

    private func requestAuthorisation(always: Bool = false) {
        if self.locationManager.authorizationStatus == .authorizedWhenInUse {
            self.locationManager.requestLocation()
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationViewModel: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if self.locationManager.authorizationStatus == .authorizedWhenInUse {
            self.locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = manager.location?.coordinate {
            DispatchQueue.main.async {
                self.lat = Double(coordinate.latitude)
                self.long = Double(coordinate.longitude)
            }
            manager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error from location manager: ", error.localizedDescription)
    }
}
