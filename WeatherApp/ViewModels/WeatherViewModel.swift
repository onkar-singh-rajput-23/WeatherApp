import SwiftUI
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var currentCity: String = "Chennai"
//    @Published var cities: [String] = []
    @Published var isLocationLoading = false
    @Published var isUsingCurrentLocation = false
    @Published var isAutoRefreshEnabled = true
    @Published var lastRefreshTime: Date = Date()
    @Published var moveToSerch: Int = 0
    
    private let networkClass = NetworkClass()
    private var cancellables = Set<AnyCancellable>()
    private var weatherTimer: Timer?
    
    private let networkMonitor = NetworkMonitor.shared
    let location = LocationViewModel.shared
    
    init() {
        // Auto-fetch weather when city changes
        $currentCity
            .dropFirst() // Skip initial value
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] city in
                print("WeatherViewModel: City changed to '\(city)', fetching weather...")
                Task {
                    await self?.fetchWeather()
                }
            }
            .store(in: &cancellables)
        
        // Start auto-refresh timer
        startAutoRefresh()
        
        // Monitor network connectivity for auto-refresh
        networkMonitor.$isConnected
            .sink { [weak self] isConnected in
                if isConnected {
                    print("🌐 WeatherViewModel: Network connected, resuming auto-refresh")
                    self?.startAutoRefresh()
                } else {
                    print("🌐 WeatherViewModel: Network disconnected, pausing auto-refresh")
                    self?.stopAutoRefresh()
                }
            }
            .store(in: &cancellables)
        
        fetchCity()
    }
    
    func navigateToSearch() {
        print("🔗 WeatherViewModel: navigateToSearch called")
        moveToSerch += 1
    }
    
    deinit {
        stopAutoRefresh()
    }
    
    // MARK: - Auto Refresh Methods
    
    private func startAutoRefresh() {
        guard isAutoRefreshEnabled && networkMonitor.isConnected else { return }
        
        stopAutoRefresh() // Stop any existing timer
        
        print("WeatherViewModel: Starting auto-refresh timer (every 1 minute)")
        weatherTimer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { [weak self] _ in
            Task {
                await self?.performAutoRefresh()
            }
        }
    }
    
    private func stopAutoRefresh() {
        weatherTimer?.invalidate()
        weatherTimer = nil
        print("WeatherViewModel: Stopped auto-refresh timer")
    }
    
    @MainActor
    private func performAutoRefresh() async {
        guard !isLoading else {
            print("WeatherViewModel: Skipping auto-refresh - already loading")
            return
        }
        
        print("WeatherViewModel: Auto-refreshing weather for '\(currentCity)'")
        await fetchWeather()
    }
    
    // MARK: - Public Methods
    
    func toggleAutoRefresh() {
        isAutoRefreshEnabled.toggle()
        if isAutoRefreshEnabled {
            startAutoRefresh()
        } else {
            stopAutoRefresh()
        }
        print("WeatherViewModel: Auto-refresh \(isAutoRefreshEnabled ? "enabled" : "disabled")")
    }
    
    func forceRefresh() async {
        print("WeatherViewModel: Force refreshing weather")
        await fetchWeather()
    }
    
    private func fetchCity() {
        location.fetchCurrentCity { [weak self] city in
            DispatchQueue.main.async {
                if let city = city {
                    self?.currentCity = city
                } else {
                    print("failed to fetch city")
                }
            }
        }
    }
    
    @MainActor
    func fetchWeather() async {
        await fetchWeather(currentCity: currentCity)
    }
    
    @MainActor
    func fetchWeather(currentCity:String) async {
        print(" WeatherViewModel: Fetching weather for '\(currentCity)'")
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await networkClass.fetchWeatherData(for:currentCity)
            weatherData = result
            lastRefreshTime = Date()
            print("WeatherViewModel: Successfully fetched weather for '\(currentCity)' at \(lastRefreshTime)")
        } catch {
            errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
            print("WeatherViewModel: Failed to fetch weather for '\(currentCity)': \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    func updateCity(_ newCity: String) {
        currentCity = newCity
    }
} 
