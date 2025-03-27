//
//  LoadingViewController.swift
//  Aviatickets
//
//  Created by Ерош Айтжанов on 26.03.2025.
//

import UIKit

class LoadingViewController: UIViewController {
    
    var returnDate: String
    var from: String
    var to: String
    var departureDate: String
    var depatureCity: String
    var arrivalCity: String
    
    // Mandatory Initializer (No Default Values)
    init(from: String, to: String, departureDate: String, returnDate: String, depatureCity: String, arrivalCity: String) {
        self.returnDate = returnDate
        self.from = from
        self.to = to
        self.departureDate = departureDate
        self.depatureCity = depatureCity
        self.arrivalCity = arrivalCity
        
        super.init(nibName: nil, bundle: nil) // Call super.init
    }
    
    // Required initializer for Storyboard/XIB (not used but required by Swift)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        //indicator.backgroundColor = .systemGray
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        activityIndicator.startAnimating()
        load()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        activityIndicator.stopAnimating()
    }
    
    func setupUI() {
        view.backgroundColor = companyColor
        navigationController?.navigationBar.tintColor = .white
        
        [activityIndicator].forEach {
            view.addSubview($0)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    func load() {
        let returnDate = self.returnDate
        let from = self.from
        let to = self.to
        let departureDate = self.departureDate
        
        if returnDate == "" {
            let flightsViewController = FlightsViewController(from: from, to: to, departureDate: departureDate, returnDate: returnDate, depatureCity: self.depatureCity, arrivalCity: self.arrivalCity)
            
            NetworkManager.shared.pricesFlights(from: from, to: to, departureDate: departureDate) { result in
                do {
                    
                    let data = try result.get() // Extract data safely
                    flightsViewController.priceData = data.data
                    
                    NetworkManager.shared.searchFlights(from: from, to: to, departureDate: departureDate) { result in
                        do {
                            let flightData = try result.get() // Extract data safely
                        
                            flightsViewController.data = flightData.data
                            
                            flightsViewController.titleLabel.text = self.depatureCity + " -- " + self.arrivalCity
                            flightsViewController.underTitleLabel.text = formatDayWithWeekday(from: departureDate)
                            
                            flightsViewController.returnIsActive = false
                            flightsViewController.flightTableView.rowHeight = 130
                            
                            if let mainVC = self.navigationController?.viewControllers.first(where: { $0 is ViewController }) {
                                self.navigationController?.setViewControllers([mainVC, flightsViewController], animated: true)
                            }
                            //self.navigationController?.pushViewController(flightsViewController, animated: true)
                        } catch {
                            showErrorAlert(message: "Check API key or internet connection", in: self)
                            print("❌ Error fetching flights: \(error.localizedDescription)")
                        }
                    }
    
                } catch {
                    showErrorAlert(message: "Check API key or internet connection", in: self)
                    print("❌ Error fetching flights: \(error.localizedDescription)")
                }
            }
            
        } else {
        
            NetworkManager.shared.searchMultiFlights(from: from, to: to, departureDate: departureDate, returnDate: returnDate) { result in
                do {
                    let flightsViewController = FlightsViewController(from: from, to: to, departureDate: departureDate, returnDate: returnDate, depatureCity: self.depatureCity, arrivalCity: self.arrivalCity)
                    flightsViewController.removePriceCollectionView()
                    
                    let flightData = try result.get() // Extract data safely
                    
                    flightsViewController.data = flightData.data
                    
                    flightsViewController.titleLabel.text = self.depatureCity + " -- " + self.arrivalCity
                    flightsViewController.underTitleLabel.text = formatDayWithWeekday(from: departureDate)! + " - " + formatDayWithWeekday(from: returnDate)!
                    
                    flightsViewController.returnIsActive = true
                    flightsViewController.flightTableView.rowHeight = 195
                    
                    if let mainVC = self.navigationController?.viewControllers.first(where: { $0 is ViewController }) {
                        self.navigationController?.setViewControllers([mainVC, flightsViewController], animated: true)
                    }
                    //self.navigationController?.pushViewController(flightsViewController, animated: true)
                } catch {
                    showErrorAlert(message: "Check API key or internet connection", in: self)
                    print("❌ Error fetching flights: \(error.localizedDescription)")
                }
            }
        }
        print("Searching for flights from \(from) to \(to) on \(departureDate) (Return: \(returnDate))")
    }
}




























