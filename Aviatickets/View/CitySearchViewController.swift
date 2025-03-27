//
//  CitySearchViewController.swift
//  Aviatickets
//
//  Created by Ерош Айтжанов on 04.03.2025.
//

import UIKit

protocol CitySearchDelegate: AnyObject {
    func didSelectCity(city: String, country: String, airportCode: String)
}

class CitySearchViewController: UIViewController {
    
    weak var delegate: CitySearchDelegate?
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private var searchResults: [[String]] = [] // This will store city names
    
    private var searchTimer: Timer? // Add a timer to debounce requests
    
    lazy var searchMainLabel: UILabel = {
        let label = UILabel()
        label.text = "From"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var notFoundLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.text = "Couldn't find city or airport"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = companyColor
        //indicator.backgroundColor = .systemGray
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        searchBar.becomeFirstResponder()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        [activityIndicator, searchMainLabel, searchBar, notFoundLabel, tableView].forEach {
            view.addSubview($0)
        }

        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        
        // Configure search bar
        searchBar.placeholder = "Enter city name"
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Layout constraints
        searchMainLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(25)
            make.leading.trailing.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(searchMainLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        notFoundLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        view.bringSubviewToFront(notFoundLabel)
    }

}

extension CitySearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate() // Cancel previous timer
        
        guard !searchText.isEmpty else {
            searchResults.removeAll()
            tableView.reloadData()
            self.activityIndicator.stopAnimating()
            tableView.alpha = 1
            notFoundLabel.alpha = 0
            return
        }
        
        // Start a new timer that waits 0.3 seconds before executing the search
        activityIndicator.startAnimating()
        notFoundLabel.alpha = 0
        tableView.alpha = 0
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            self.performSearch(query: searchText)
        }
    }
    
    private func performSearch(query: String) {
        NetworkManager.shared.searchAirports(query: query) { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.alpha = 1
                do {
                    let flightData = try result.get()
                    self.searchResults = flightData.data.map { [$0.cityName ?? "Not found", $0.countryName ?? "", $0.code] }
                    
                    if self.searchResults.isEmpty {
                        self.notFoundLabel.alpha = 1
                    } else {
                        self.notFoundLabel.alpha = 0
                    }
                    
                    self.tableView.reloadData()
                } catch {
                    showErrorAlert(message: "Check API key or internet connection", in: self)
                    print("❌ Error fetching airports: \(error.localizedDescription)")
                }
            }
        }
    }
}

extension CitySearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = searchResults[indexPath.row][0] + ", " + searchResults[indexPath.row][1] + " (" + searchResults[indexPath.row][2] + ")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = searchResults[indexPath.row][0]
        let selectedCountry = searchResults[indexPath.row][1]
        let airportCode = searchResults[indexPath.row][2]
        
        delegate?.didSelectCity(city: selectedCity, country: selectedCountry, airportCode: airportCode)
        dismiss(animated: true)
    }
}

