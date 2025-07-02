////
////  SearchButtonView.swift
////  WeatherApp
////
////  Created by onkar.rajput on 02/07/25.
////
//
//import SwiftUI
//
//struct SearchButtonView: View {
//    @State private var showSearch = false
//
//        var body: some View {
//            VStack {
//                Button(action: {
//                    showSearch = true
//                }) {
//                    Image(systemName: "magnifyingglass")
//                        .font(.system(size: 30))
//                        .foregroundColor(.blue)
//                }
//            }
//            .fullScreenCover(isPresented: $showSearch) {
//                SearchResultWrapper()
//            }
//        }
//}
//
//#Preview {
//    SearchButtonView()
//}
