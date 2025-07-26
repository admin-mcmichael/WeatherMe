//
//  LocationManager.swift
//  WeatherMe
//
//  Created by Luke on 26/7/2025.
//

import CoreLocation
import Foundation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var location: CLLocation?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latest = locations.first else { return }
        DispatchQueue.main.async {
            self.location = latest
        }
    }
}
