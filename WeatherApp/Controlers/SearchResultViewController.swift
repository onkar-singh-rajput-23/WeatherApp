//
//  SearchResultViewController.swift
//  WeatherApp
//
//  Created by onkar.rajput on 01/07/25.
//

import UIKit
import Combine

class SearchResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let weatherViewModel: WeatherViewModel
    private let searchViewModel = CitySearchViewModel()
    private var cancellables = Set<AnyCancellable>()

    private let searchTextField = UITextField()
    private let tableView = UITableView()

    private var filteredCities: [String] = []

    // MARK: - Init
    init(weatherViewModel: WeatherViewModel) {
        self.weatherViewModel = weatherViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search Results"
        view.backgroundColor = .systemBackground

        setupSearchField()
        setupTableView()
        bindTextFieldToViewModel()
        observeCitySuggestions()
    }

    // MARK: - UI Setup

    private func setupSearchField() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))

        searchTextField.placeholder = "Search for a city"
        searchTextField.borderStyle = .roundedRect
        searchTextField.frame = CGRect(x: 16, y: 10, width: view.frame.width - 32, height: 40)

        headerView.addSubview(searchTextField)
        tableView.tableHeaderView = headerView
    }

    private func setupTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }

    // MARK: - Bindings

    private func bindTextFieldToViewModel() {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: searchTextField)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink { [weak self] text in
                self?.searchViewModel.searchText = text
            }
            .store(in: &cancellables)
    }

    private func observeCitySuggestions() {
        searchViewModel.$citySuggestions
            .receive(on: RunLoop.main)
            .sink { [weak self] cities in
                self?.filteredCities = cities
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    // MARK: - UITableViewDataSource & Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }

        let city = filteredCities[indexPath.row]
        cell.setUI(cityName: city, parentVC: self)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = filteredCities[indexPath.row]
        print("🏙️ Selected city: \(selectedCity)")
        
        // Update the shared WeatherViewModel
        weatherViewModel.currentCity = selectedCity
        
        // Pop back to previous view controller
        navigationController?.popViewController(animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
