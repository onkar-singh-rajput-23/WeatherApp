//
//  CitySearchViewModel.swift
//  WeatherApp
//
//  Created by onkar.rajput on 02/07/25.
//

import Foundation
import MapKit
import Combine

class CitySearchViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchText: String = ""
    @Published var citySuggestions: [String] = []

    private let completer = MKLocalSearchCompleter()
    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()
        completer.delegate = self
        completer.resultTypes = .address

        $searchText
            .debounce(for: .milliseconds(600), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty, trimmed.count >= 2 else { return }
                print("🔍 Query: \(trimmed)")
                self?.completer.queryFragment = trimmed
            }
            .store(in: &cancellables)
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            print("Received \(completer.results.count) results")
            self.citySuggestions = completer.results.map { $0.title }
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(" Completer failed: \(error.localizedDescription)")
    }
}
