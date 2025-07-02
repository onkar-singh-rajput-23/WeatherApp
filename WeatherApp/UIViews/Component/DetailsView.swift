//
//  DetailsView.swift
//  WeatherApp
//
//  Created by onkar.rajput on 17/06/25.
//

import SwiftUI

struct DetailsView: View {
    let weather: WeatherResponse
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 2) {
                Text("\(Int(weather.current.tempC))")
                    .font(.system(size: 120, weight: .bold))
                    .foregroundStyle(.primary)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("°C")
                        .font(.system(size: 30, weight: .light))
                        .padding(.top, 10)
                }
            }
            
            HStack {
                Text(weather.current.condition.text)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.gray)
            }
            
            HStack {
                let maxTemp = weather.forecast.forecastday.first?.day.maxtempC ?? 0
                let minTemp = weather.forecast.forecastday.first?.day.mintempC ?? 0
                Text("\(Int(minTemp)) ~ \(Int(maxTemp))°C    Feels like \(Int(weather.current.feelslikeC))°C")
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.85))
            }
        }
    }
}
let dummyAirQuality = AirQuality(
    co: 0.4,
    no2: 0.015,
    o3: 0.025,
    so2: 0.003,
    pm2_5: 18.0,
    pm10: 25.0,
    usEpaIndex: 2,
    gbDefraIndex: 3
)
#Preview {
    DetailsView(weather: WeatherResponse(
        location: Location(
            name: "Kanpur",
            region: "Uttar Pradesh",
            country: "India",
            lat: 26.4667,
            lon: 80.35,
            tzId: "Asia/Kolkata",
            localtimeEpoch: 1750179148,
            localtime: "2025-06-17 22:22"
        ),
        current: CurrentWeather(
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
        ),
        forecast: Forecast(forecastday: [])
    ))
}
