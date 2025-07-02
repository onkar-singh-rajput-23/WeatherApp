//
//  HoursDetail.swift
//  WeatherApp
//
//  Created by onkar.rajput on 17/06/25.
//

import SwiftUI

struct HoursDetail: View {
    var time: String
        var iconName: String
        var windIcon: String
        var uvLevel: String
    
    var body: some View {
                VStack(spacing: 4) {
                    Image(systemName: iconName)
                        .font(.system(size: 24))
                        .foregroundColor(.blue)

                    Image(systemName: windIcon)
                        .font(.system(size: 18))
                        .foregroundColor(.gray)

            Text("Temp")
                        .font(.caption)
                        .foregroundColor(.purple)
                    Text(uvLevel)
                        .font(.caption2)
                        .foregroundColor(.purple)

                    Text(time)
                        .font(.footnote)
                        .foregroundColor(.primary)
                }
                .frame(width: 50)
    }
}

#Preview {
    HoursDetail(time: "14:00", iconName: "sun.max.fill", windIcon: "wind", uvLevel: "25°")
}
