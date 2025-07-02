//
//  HoursView.swift
//  WeatherApp
//
//  Created by onkar.rajput on 17/06/25.
//

import SwiftUI

struct HoursView: View {
    let forecast: Forecast
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(forecast.forecastday.prefix(1).first?.hour.prefix(24) ?? []), id: \.timeEpoch) { hour in
                    HoursDetail(
                        time: formatTime(hour.time),
                        iconName: getWeatherIcon(hour.condition.code),
                        windIcon: "wind",
                        uvLevel: "\(Int(hour.tempC))°"
                    )
                }
            }
        }
            .padding(10)
    }
        
    private func formatTime(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let date = formatter.date(from: timeString) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            return timeFormatter.string(from: date)
        }
        return "00:00"
    }
    
    private func getWeatherIcon(_ code: Int) -> String {
        switch code {
        case 1000: return "sun.max.fill" // Clear
        case 1003: return "cloud.sun.fill" // Partly cloudy
        case 1006: return "cloud.fill" // Cloudy
        case 1009: return "cloud.fill" // Overcast
        case 1030: return "cloud.fog.fill" // Mist
        case 1063, 1150, 1153, 1180, 1183, 1186, 1189: return "cloud.drizzle.fill" // Light rain
        case 1066, 1210, 1213, 1216, 1219, 1222, 1225: return "cloud.snow.fill" // Snow
        case 1069, 1204, 1207: return "cloud.sleet.fill" // Sleet
        case 1087: return "cloud.bolt.fill" // Thunder
        case 1114, 1117: return "wind" // Blizzard
        case 1135, 1147: return "cloud.fog.fill" // Fog
        case 1192, 1195, 1243, 1246: return "cloud.heavyrain.fill" // Heavy rain
        case 1273, 1276: return "cloud.bolt.rain.fill" // Thunder and rain
        default: return "cloud.fill"
        }
    }
}

#Preview {
    HoursView(forecast: Forecast(forecastday: []))
}
