//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by onkar.rajput on 01/07/25.
//

import UIKit
import CoreLocation

class LocationViewModel: NSObject, CLLocationManagerDelegate {
    
    static var shared = LocationViewModel()

    private let locationManager = CLLocationManager()
    private var onCityFetched: ((String?) -> Void)?
    private var hasReturnedLocation = false

    override init() {
        super.init()
        configureLocationManager()
    }

    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    /// Provide this method to start fetching city
    func fetchCurrentCity(completion: @escaping (String?) -> Void) {
        self.onCityFetched = completion
    }

    // MARK: - CLLocationManagerDelegate

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Authorization granted — starting location updates")
            locationManager.startUpdatingLocation()
        case .notDetermined:
            print("Authorization not yet determined")
        case .restricted:
            print("Authorization restricted")
            onCityFetched?(nil)
        case .denied:
            print("Authorization denied")
            onCityFetched?(nil)
        @unknown default:
            print("Unknown authorization status")
            onCityFetched?(nil)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !hasReturnedLocation, let location = locations.last else { return }

        hasReturnedLocation = true
        locationManager.stopUpdatingLocation()

        print("Coordinates: \(location.coordinate.latitude), \(location.coordinate.longitude)")

        reverseGeocode(location: location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError {
            switch clError.code {
            case .locationUnknown:
                print("Location unknown — waiting for a valid fix...")
                // ✅ Do NOT call completion here, just wait for new updates
                return
            case .denied:
                print(" Location access denied by user")
                onCityFetched?(nil)
            default:
                print("Location error: \(clError.localizedDescription)")
                onCityFetched?(nil)
            }
        } else {
            print("Unexpected location error: \(error.localizedDescription)")
            onCityFetched?(nil)
        }
    }

    // MARK: - Reverse Geocode to City

    private func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }

            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                self.onCityFetched?(nil)
                return
            }

            if let city = placemarks?.first?.locality {
                print("🏙️ Current city: \(city)")
                self.onCityFetched?(city)
            } else {
                print("❌ Unable to extract city from placemark")
                self.onCityFetched?(nil)
            }
        }
    }
}
