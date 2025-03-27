//
//  FlightsViewController.swift
//  Aviatickets
//
//  Created by Ерош Айтжанов on 20.02.2025.
//

import UIKit



class FlightsViewController: UIViewController {
    
    var flights: [FlightOffer?]?
    var priceData: [DatumNew?]?
    var returnIsActive = false
    
    private lazy var pricesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal  // Can be .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PriceCollectionViewCell.self, forCellWithReuseIdentifier: "price")
        collectionView.backgroundColor = .systemGray6
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.contentInset.left = 15
        collectionView.contentInset.right = 15
        
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    lazy var flightTableView: UITableView = {
        let table = UITableView()
        table.alpha = 1
        table.backgroundColor = .systemGray6 // same as contentView color in setupUI() in FlightTableViewCell
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(FlightTableViewCell.self, forCellReuseIdentifier: "flight")
        table.rowHeight = 130
        return table
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Almaty -- Aktobe"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var underTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "14 may, 1adt"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            if let navigationController = navigationController,
               let mainVC = navigationController.viewControllers.first(where: { $0 is ViewController }) {
                navigationController.setViewControllers([mainVC], animated: true)
            }
        }
    }
    
    func setupUI() {
        view.backgroundColor = companyColor
        
        navigationController?.navigationBar.tintColor = .white
        
        let titleView = UIView()
        navigationItem.titleView = titleView
        
        [titleLabel, underTitleLabel].forEach {
            titleView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        underTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        [pricesCollectionView, flightTableView, bottomView].forEach {
            view.addSubview($0)
        }
        
        pricesCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.height.equalTo(75)
        }
        
        flightTableView.snp.makeConstraints { make in
            make.top.equalTo(pricesCollectionView.snp.bottom).offset(0)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(flightTableView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func removePriceCollectionView() {
        pricesCollectionView.removeFromSuperview()
        flightTableView.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func openFlightDetail(flight: FlightOffer) {
        
        let detailVC = FlightDetailViewController()
        detailVC.flight = flight
        detailVC.modalPresentationStyle = .automatic
        
        
        if let sheet = detailVC.sheetPresentationController {
            sheet.detents = [.medium()] // Enables draggable sizes
            sheet.prefersGrabberVisible = true // Shows the mini-line
            
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        
        present(detailVC, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FlightsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (flights?.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = flightTableView.dequeueReusableCell(withIdentifier: "flight", for: indexPath) as! FlightTableViewCell
        let flight = flights![indexPath.row]
        cell.conf(flight: flight!)
        if returnIsActive {
            cell.confReturn(flight: flight!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentFlight = flights![indexPath.row]!
        openFlightDetail(flight: currentFlight)
    }
    
}

extension FlightsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return priceData?.count ?? 0 // Number of items
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "price", for: indexPath) as! PriceCollectionViewCell
        
        cell.conf(data: priceData![indexPath.row]!)  // Custom method to configure cell
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 55)  // Size of each item
    }
}
