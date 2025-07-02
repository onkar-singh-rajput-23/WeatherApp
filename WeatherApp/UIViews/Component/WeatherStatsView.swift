//
//  WeatherStatsView.swift
//  WeatherApp
//
//  Created by onkar.rajput on 17/06/25.
//

import SwiftUI

struct WeatherStatsView: View {
    let current: CurrentWeather
    
    var body: some View {
        VStack(spacing: 12) {
            // 2 rows × 3 columns (Feel like, Wind, etc.)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 20) {
                
                VStack(spacing: 6) {
                    Image(systemName: "thermometer")
                        .foregroundColor(.blue)
                    Text("Feels like")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(Int(current.feelslikeC))°C")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }

                VStack(spacing: 6) {
                    Image(systemName: "wind")
                        .foregroundColor(.blue)
                    Text(current.windDir)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(Int(current.windKph)) km/h")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }

                VStack(spacing: 6) {
                    Image(systemName: "drop.fill")
                        .foregroundColor(.blue)
                    Text("Humidity")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(current.humidity)%")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }

                VStack(spacing: 6) {
                    Image(systemName: "sun.min.fill")
                        .foregroundColor(.blue)
                    Text("UV")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(Int(current.uv))")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }

                VStack(spacing: 6) {
                    Image(systemName: "eye.fill")
                        .foregroundColor(.blue)
                    Text("Visibility")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(Int(current.visKm)) km")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }

                VStack(spacing: 6) {
                    Image(systemName: "gauge")
                        .foregroundColor(.blue)
                    Text("Pressure")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(Int(current.pressureIn)) in")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }
            .padding()
        }
        .background(Color.clear)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5)
        .padding(.horizontal)
    }
}

#Preview {
    WeatherStatsView(current: CurrentWeather(
        lastUpdatedEpoch: 1750179148,
        lastUpdated: "2025-06-17 22:22",
        tempC: 25.0,
        isDay: 0,
        condition: WeatherCondition(text: "Clear", icon: "113", code: 1000),
        windKph: 10.0,
        windDir: "N",
        pressureIn: 29.5,
        precipMm: 0.0,
        precipIn: 0.0,
        humidity: 60,
        cloud: 0,
        feelslikeC: 26.0,
        dewpointC: 17.0,
        visKm: 10.0,
        uv: 5.0, airQuality: dummyAirQuality
    ))
}
