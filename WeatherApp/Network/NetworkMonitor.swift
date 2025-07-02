//
//  NetworkMonitor.swift
//  WeatherApp
//
//  Created by onkar.rajput on 01/07/25.
//

import Foundation
import Network
import Combine

final class NetworkMonitor: ObservableObject {
    public static let shared = NetworkMonitor()
    @Published public private(set) var isConnected: Bool = true
    private let queue = DispatchQueue.global()
    private var monitor: NWPathMonitor!
    
    private init(){
        monitor = NWPathMonitor()
        startMonitoring()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                if self?.isConnected == true {
                    print("🌐 Network is connected")
                } else {
                    print("🌐 Network is not connected")
                }
            }
        }
    }
    
    deinit {
        monitor?.cancel()
    }
}
