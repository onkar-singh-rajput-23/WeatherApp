//
//  DataFetching.swift
//  WeatherApp
//
//  Created by onkar.rajput on 17/06/25.
//

import Foundation

class NetworkClass {
    private let apiKey = "7b2d94a9164e4ac99bb74308253006"
    private let baseURL = "https://api.weatherapi.com/v1/forecast.json"
    
    func fetchWeatherData(for city: String = "kanpur") async throws -> WeatherResponse {
        
        let urlString = "\(baseURL)?key=\(apiKey)&q=\(city)&days=7&aqi=yes&alerts=no"

        guard let url = URL(string: urlString) else {
//            print("Invalid URL: \(urlString)")
            throw URLError(.badURL)
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
//                print("Invalid HTTP response")
                throw URLError(.badServerResponse)
            }
            
            guard httpResponse.statusCode == 200 else {
//                print("HTTP Error: \(httpResponse.statusCode)")
//                if let errorData = String(data: data, encoding: .utf8) {
////                    print("Error Response: \(errorData)")
//                }
                throw URLError(.badServerResponse)
            }
            
//            print("Received data size: \(data) bytes")
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            
            do {
                let weather = try decoder.decode(WeatherResponse.self, from: data)
                print(" Current temperature: \(weather.current.tempC)°C")
//                print(weather)
                return weather
            } catch {
                print("Decoding error: \(error)")
                print("Decoding error details: \(error.localizedDescription)")
                
                
                throw error
            }
        } catch {
//            print("Network error: \(error)")
//            print("Network error details: \(error.localizedDescription)")
            throw error
        }
    }
}
