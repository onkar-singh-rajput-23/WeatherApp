//
//  HeadeView.swift
//  WeatherApp
//
//  Created by onkar.rajput on 17/06/25.
//

import SwiftUI

struct HeadeView: View {
    @ObservedObject var weatherViewModel : WeatherViewModel
    var body: some View {
        HStack {
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
    }
}

#Preview {
    HeadeView(weatherViewModel: WeatherViewModel())
}
