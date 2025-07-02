//
//  ListCellView.swift
//  WeatherApp
//
//  Created by onkar.rajput on 17/06/25.
//

import SwiftUI

struct ListCellView: View {
    
    let cityName:String
    var body: some View {
        
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)),    // Bright blue
                            Color(#colorLiteral(red: 0.9039573073, green: 0.9039573073, blue: 0.9039573073, alpha: 1))     // Light blue
                        ]),
                        startPoint: .bottomTrailing,
                        endPoint: .topLeading
                        
                    )
                    .overlay(
                        Image("clouds")
                            .resizable()
                            .scaledToFill()
                            .opacity(0.2)
                    )
                    .cornerRadius(16)

                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            HStack(spacing: 6) {
                                Text("\(cityName)")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Image(systemName: "location.fill")
                                    .foregroundColor(.black)
                                    .font(.caption)
                            }

                        }

                        Spacer()
                    }
                    .padding()
                }
                .frame(height: 70)
                .padding(.horizontal, 5)
                .padding(.vertical, 0)
            }
}

#Preview {
    ListCellView(cityName: "delhi")
}
