//
//  HomeVIewContollerViewController.swift
//  WeatherApp
//
//  Created by onkar.rajput on 17/06/25.
//

import UIKit
import SwiftUI
import Combine

class HomeViewContoller: UIHostingController<HomeView> {
    let viewModel: WeatherViewModel = WeatherViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let weatherView = HomeView(weatherViewModel: viewModel)
        super.init(rootView: weatherView)
    }
    
    required init?(coder: NSCoder) {
        let weatherView = HomeView(weatherViewModel: viewModel)
        super.init(coder: coder, rootView: weatherView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationObserver()
    }
    
    // MARK: - Reactive Navigation Setup
    private func setupNavigationObserver() {
        print("🔗 Setting up navigation observer")
        viewModel
            .$moveToSerch
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                print("🔗 Navigation observer triggered with value: \(value)")
                
                if value > 0 {
                    self.navigateToSearchPage()
                }
            }
            .store(in: &cancellables)
    }
    
    func navigateToSearchPage() {
        print("🚀 Navigating to search page")
        let searchVC = SearchResultViewController(weatherViewModel: viewModel)
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    // MARK: - Public Navigation Trigger
    func triggerSearchNavigation() {
        print("🔗 Triggering search navigation")
        viewModel.moveToSerch += 1
    }
}
