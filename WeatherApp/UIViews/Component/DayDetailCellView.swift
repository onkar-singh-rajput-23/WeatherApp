//
//  DayDetailCellView.swift
//  WeatherApp
//
//  Created by onkar.rajput on 17/06/25.
//

import SwiftUI

struct DayDetailCellView: View {
    let forecastDay: ForecastDay
    
    var body: some View {
        HStack(spacing: 16) {
            VStack {
                Text(formatDate(forecastDay.date))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(width: 60, alignment: .leading)

            VStack {
                Text(getDayName(forecastDay.date))
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            .frame(width: 80, alignment: .leading)

            VStack(spacing: 4) {
                Image(systemName: getWeatherIcon(forecastDay.day.condition.code))
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                Text("\(forecastDay.day.dailyChanceOfRain)%")
                    .font(.caption2)
                    .foregroundColor(.blue)
            }
            .frame(width: 60)

            VStack {
                Text("\(Int(forecastDay.day.mintempC))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(width: 40)

            VStack {
                Text("\(Int(forecastDay.day.maxtempC))")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            .frame(width: 40)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: dateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd"
            return dateFormatter.string(from: date)
        }
        return "00/00"
    }
    
    private func getDayName(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: dateString) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            let dayName = dayFormatter.string(from: date)
            
            // Check if it's today
            let today = Date()
            let calendar = Calendar.current
            if calendar.isDate(date, inSameDayAs: today) {
                return "Today"
            }
            return dayName
        }
        return "Unknown"
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
    DayDetailCellView(forecastDay: ForecastDay(
        date: "2025-06-17",
        dateEpoch: 1750179148,
        day: DayForecast(
            maxtempC: 30.0,
            mintempC: 20.0,
            avgtempC: 25.0,
            maxwindKph: 15.0,
            totalprecipMm: 0.0,
            avgvisKm: 10.0,
            avghumidity: 60,
            dailyWillItRain: 0,
            dailyChanceOfRain: 10,
            condition: WeatherCondition(text: "Clear", icon: "113", code: 1000),
            uv: 5.0
        ),
        astro: Astro(
            sunrise: "06:00",
            sunset: "18:00",
            moonrise: "12:00",
            moonset: "00:00",
            moonPhase: "Full",
            moonIllumination: 100.0,
            isMoonUp: 1,
            isSunUp: 1
        ),
        hour: []
    ))
}
