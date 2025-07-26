//
//  WeatherService.swift
//  WeatherMe
//
//  Created by Luke on 26/7/2025.
//

import Foundation

func triggerPush(lat: Double, lon: Double, token: String) {
    guard let url = URL(string: "https://weatherme-m7mx.onrender.com/notify") else { return }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let body: [String: Any] = [
        "lat": lat,
        "lon": lon,
        "token": token
    ]

    request.httpBody = try? JSONSerialization.data(withJSONObject: body)

    URLSession.shared.dataTask(with: request).resume()
}
