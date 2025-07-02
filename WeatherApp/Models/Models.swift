//
//  File.swift
//  WeatherApp
//
//  Created by onkar.rajput on 17/06/25.
//

import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}
struct AirQuality: Codable {
    let co: Double?
    let no2: Double?
    let o3: Double?
    let so2: Double?
    let pm2_5: Double?
    let pm10: Double?
    let usEpaIndex: Int?
    let gbDefraIndex: Int?

//    enum CodingKeys: String, CodingKey {
//        case co, no2, o3, so2, pm2_5 = "pm2_5", pm10
//        case usEpaIndex = "us-epa-index"
//        case gbDefraIndex = "gb-defra-index"
//    }
}
struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tzId: String
    let localtimeEpoch: Int
    let localtime: String
}
//        "name": "Kanpur",
//        "region": "Uttar Pradesh",
//        "country": "India",
//        "lat": 26.4667,
//        "lon": 80.35,
//        "tz_id": "Asia/Kolkata",
//        "localtime_epoch": 1750179148,
//        "localtime": "2025-06-17 22:22"

struct CurrentWeather: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC: Double
    let isDay: Int
    let condition: WeatherCondition
    let windKph: Double
    let windDir: String
    let pressureIn: Double
    let precipMm: Double
    let precipIn: Double
    let humidity: Int
    let cloud: Int
    let feelslikeC: Double
    let dewpointC: Double
    let visKm: Double
    let uv: Double
    let airQuality: AirQuality
}

struct WeatherCondition: Codable {
    let text: String
    let icon: String
    let code: Int
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: String
    let dateEpoch: Int
    let day: DayForecast
    let astro: Astro
    let hour: [HourlyForecast]
}

struct DayForecast: Codable {
    let maxtempC: Double
    let mintempC: Double
    let avgtempC: Double
    let maxwindKph: Double
    let totalprecipMm: Double
    let avgvisKm: Double
    let avghumidity: Int
    let dailyWillItRain: Int
    let dailyChanceOfRain: Int
    let condition: WeatherCondition
    let uv: Double
}

struct Astro: Codable {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
    let moonPhase: String
    let moonIllumination: Double
    let isMoonUp: Int
    let isSunUp: Int
}

struct HourlyForecast: Codable {
    let timeEpoch: Int
    let time: String
    let tempC: Double
    let isDay: Int
    let condition: WeatherCondition
    let windKph: Double
    let windDir: String
    let pressureIn: Double
    let precipMm: Double
    let precipIn: Double
    let humidity: Int
    let cloud: Int
    let feelslikeC: Double
    let chanceOfRain: Int
    let visKm: Double
    let uv: Double
}


extension Location {
static let mock = Location(
name: "Kanpur",
region: "Uttar Pradesh",
country: "India",
lat: 26.4667,
lon: 80.35,
tzId: "Asia/Kolkata",
localtimeEpoch: 1750179148,
localtime: "2025-06-17 22:22"
)
}

extension WeatherCondition {
static let mock = WeatherCondition(
text: "Sunny",
icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
code: 1000
)
}

extension AirQuality {
static let mock = AirQuality(
co: 0.4,
no2: 15.5,
o3: 30.2,
so2: 3.1,
pm2_5: 12.5,
pm10: 24.8,
usEpaIndex: 2,
gbDefraIndex: 3
)
}

extension CurrentWeather {
static let mock = CurrentWeather(
lastUpdatedEpoch: 1750179000,
lastUpdated: "2025-06-17 22:22",
tempC: 34.5,
isDay: 1,
condition: .mock,
windKph: 12.3,
windDir: "NE",
pressureIn: 29.8,
precipMm: 0.0,
precipIn: 0.0,
humidity: 56,
cloud: 20,
feelslikeC: 37.0,
dewpointC: 24.0,
visKm: 10.0,
uv: 5.0,
airQuality: .mock
)
}

extension DayForecast {
static let mock = DayForecast(
maxtempC: 36.0,
mintempC: 28.0,
avgtempC: 32.0,
maxwindKph: 14.5,
totalprecipMm: 0.0,
avgvisKm: 10.0,
avghumidity: 60,
dailyWillItRain: 0,
dailyChanceOfRain: 10,
condition: .mock,
uv: 6.0
)
}

extension Astro {
static let mock = Astro(
sunrise: "5:12 AM",
sunset: "6:45 PM",
moonrise: "10:34 PM",
moonset: "9:21 AM",
moonPhase: "Waning Crescent",
moonIllumination: 38.0,
isMoonUp: 1,
isSunUp: 1
)
}

extension HourlyForecast {
static let mock = HourlyForecast(
timeEpoch: 1750179600,
time: "2025-06-17 22:30",
tempC: 30.0,
isDay: 0,
condition: .mock,
windKph: 10.0,
windDir: "N",
pressureIn: 29.7,
precipMm: 0.0,
precipIn: 0.0,
humidity: 58,
cloud: 15,
feelslikeC: 33.0,
chanceOfRain: 5,
visKm: 10.0,
uv: 3.0
)
}

extension ForecastDay {
static let mock = ForecastDay(
date: "2025-06-17",
dateEpoch: 1750176000,
day: .mock,
astro: .mock,
hour: Array(repeating: .mock, count: 24)
)
}

extension Forecast {
static let mock = Forecast(
forecastday: [.mock, .mock, .mock]
)
}

extension WeatherResponse {
static let mock = WeatherResponse(
location: .mock,
current: .mock,
forecast: .mock
)
}
