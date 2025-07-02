//
//  HomeView.swift
//  WeatherApp
//
//  Created by onkar.rajput on 17/06/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)),
                    Color(#colorLiteral(red: 0.9039573073, green: 0.9039573073, blue: 0.9039573073, alpha: 1))    
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                HStack{
                    
                        VStack {
                            HStack {
                                Text(weatherViewModel.currentCity)
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                                
                                if weatherViewModel.isUsingCurrentLocation {
                                    Image(systemName: "location.fill")
                                        .foregroundColor(.green)
                                        .font(.system(size: 14))
                                }
                            }
                        }
                        Spacer()
                        
                        HStack(spacing: 12) {
                            
                            // Search Button
                            Button(action: {
                                print("button tapped ")
                                weatherViewModel.navigateToSearch()
                            }) {
                                Text("Search")
                            }
            //                Button("image", image: "clouds", action: HomeViewContoller().navigateTosearch)
            //                ButtonViewControllerWrapper(weatherViewModel: weatherViewModel)
            //                    .frame(width: 50, height: 50)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [
                            Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)),
                            Color(#colorLiteral(red: 0.3602206707, green: 0.5812368989, blue: 0.7812436819, alpha: 1))
                        ]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                    )
//                {
//                    HeadeView(weatherViewModel: weatherViewModel)
//                }
                .frame(maxWidth: .infinity, idealHeight: 100, maxHeight: 100, alignment: .center)
                
                if weatherViewModel.isLoading || weatherViewModel.isLocationLoading {
                    Spacer()
                    VStack(spacing: 16) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                        
                        if weatherViewModel.isLocationLoading {
                            Text("Getting your location...")
                                .foregroundColor(.white)
                                .font(.headline)
                        } else {
                            Text("Loading weather data...")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    }
                    Spacer()
                } else if let error = weatherViewModel.errorMessage {
                    Spacer()
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                        Text(error)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Retry") {
                            Task {
                                await weatherViewModel.fetchWeather()
                            }
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                    Spacer()
                } else if let weather = weatherViewModel.weatherData {
                    ScrollView {
                        VStack {
                            HStack {
                                DetailsView(weather: weather)
                            }
                            HStack {
                                HoursView(forecast: weather.forecast)
                            }
                            DayDeailVeiw(forecast: weather.forecast)
                            WeatherStatsView(current: weather.current)
                            AQIView(current: weather.current)
                        }
                    }
                } else {
                    Spacer()
                    VStack(spacing: 20) {
                        Text("No weather data available")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        // Show location button if no data
                        
                    }
                    Spacer()
                }
            }
        }
        .task {
            print("🏠 HomeView: App started, fetching weather...")
            await weatherViewModel.fetchWeather()
        }
        .refreshable {
            print("🔄 HomeView: Pull to refresh triggered")
            await weatherViewModel.fetchWeather()
        }
    }
}

#Preview {
    HomeView(weatherViewModel: WeatherViewModel())
}

struct WeatherAPIError: Codable {
    let error: WeatherAPIErrorDetail
}
struct WeatherAPIErrorDetail: Codable {
    let code: Int
    let message: String
}

