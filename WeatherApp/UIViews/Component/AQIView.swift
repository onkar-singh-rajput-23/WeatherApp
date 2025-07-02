//
//  AQIView.swift
//  WeatherApp
//
//  Created by onkar.rajput on 17/06/25.
//

import SwiftUI

struct AQIView: View {
    let current:CurrentWeather
    var body: some View {
        
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text("\(current.airQuality.usEpaIndex ?? 0)")
                        .font(.system(size: 36, weight: .bold))
                }

                ZStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Color.green.frame(maxWidth: .infinity)
                        Color.yellow.frame(maxWidth: .infinity)
                        Color.orange.frame(maxWidth: .infinity)
                        Color.pink.frame(maxWidth: .infinity)
                        Color.purple.frame(maxWidth: .infinity)
                    }
                    .frame(height: 10)
                    .cornerRadius(5)

                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 2, height: 16)
                        .offset(x: UIScreen.main.bounds.width * 0.1)
                }

                HStack(spacing: 24) {
                    VStack(spacing: 4) {
                        Text("PM 2.5")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(Int(current.airQuality.pm2_5 ?? 0))")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Color.purple.frame(width: 30, height: 4).cornerRadius(1)
                    }
                    VStack(spacing: 4) {
                        Text("PM10")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(Int(current.airQuality.pm10 ?? 0))")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Color.orange.frame(width: 30, height: 4).cornerRadius(1)
                    }
                    VStack(spacing: 4) {
                        Text("CO")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(Int(current.airQuality.co ?? 00))")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Color.yellow.frame(width: 30, height: 4).cornerRadius(1)
                    }
                    VStack(spacing: 4) {
                        Text("SO2")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(Int(current.airQuality.so2 ?? 0) )")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Color.green.frame(width: 30, height: 4).cornerRadius(1)
                    }
                }
            }
            .padding()
            .background(Color.clear)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 5)
            .padding(.horizontal)
        }
}

#Preview {
    AQIView(current: .mock)
}
