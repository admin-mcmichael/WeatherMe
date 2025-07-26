//
//  ContentView.swift
//  WeatherMe
//
//  Created by Luke on 26/7/2025.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cloud.rain")
                .imageScale(.large)
                .foregroundStyle(.blue)

            Text("WeatherMe")

            if let location = locationManager.location {
                Text("Your Location:")
                Text("Lat: \(location.coordinate.latitude)")
                Text("Lon: \(location.coordinate.longitude)")

                Button("Check Rain") {
                    triggerPush(
                        lat: location.coordinate.latitude,
                        lon: location.coordinate.longitude,
                        token: "3bfdf02942480ab6ff736f1ccc0b2a0c"
                    )
                }
            } else {
                Text("Getting location...")
            }
        }
        .padding()
        .onChange(of: locationManager.location) { newLocation in
            guard let loc = newLocation else { return }
            triggerPush(
                lat: loc.coordinate.latitude,
                lon: loc.coordinate.longitude,
                token: "<3bfdf02942480ab6ff736f1ccc0b2a0c>"
            )
        }
    }
}
