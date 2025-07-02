//
//  DayDeailVeiw.swift
//  WeatherApp
//
//  Created by onkar.rajput on 17/06/25.
//

import SwiftUI

struct DayDeailVeiw: View {
    let forecast: Forecast
    
    var body: some View {
        VStack {
            ForEach(forecast.forecastday, id: \.date) { day in
                DayDetailCellView(forecastDay: day)
            }
        }
    }
}

#Preview {
    DayDeailVeiw(forecast: Forecast(forecastday: []))
}
