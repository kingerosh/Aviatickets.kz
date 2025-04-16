//
//  FlightDetailViewController.swift
//  Aviatickets
//
//  Created by Ерош Айтжанов on 14.03.2025.
//

import UIKit
import SnapKit

class FlightDetailViewController: UIViewController {
    
    var flight: FlightOffer?
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Flight details"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mainDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var flightDetailTableView: UITableView = {
        let table = UITableView()
        table.alpha = 1
        table.backgroundColor = .systemBackground
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(FlightDetailTableViewCell.self, forCellReuseIdentifier: "flightDetail")
        table.rowHeight = 500
        return table
    }()
    
    private lazy var priceLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .left
        title.text = "69 000 T"
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = companyColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private let priceContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.black.cgColor  // Shadow color
        view.layer.shadowOpacity = 0.2  // Opacity (0 = no shadow, 1 = solid)
        view.layer.shadowOffset = CGSize(width: 1, height: -1)  // Offset (X, Y)
        view.layer.shadowRadius = 2  // Blur radius
        view.layer.masksToBounds = false  // Ensure shadow is visible outside the view bounds
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        priceLabel.text = formatPrice(flight?.priceBreakdown?.total.units ?? 0) + " ₸"
        continueButton.isEnabled = false
        continueButton.backgroundColor = .gray
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        [mainLabel, mainDividerView, flightDetailTableView, priceContainer].forEach {
            view.addSubview($0)
        }
        
        [priceLabel, continueButton].forEach {
            priceContainer.addSubview($0)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        mainDividerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
            make.height.equalTo(1.5)
        }
        
        flightDetailTableView.snp.makeConstraints { make in
            make.top.equalTo(mainDividerView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        priceContainer.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(flightDetailTableView.snp.bottom)
            make.height.equalTo(100)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(20)
            
        }
        
        continueButton.snp.makeConstraints { make in
            make.leading.equalTo(priceContainer.snp.centerX).offset(-40)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.bringSubviewToFront(priceContainer)
    }

}

extension FlightDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flight?.segments.count == 1 {
            return flight?.segments.first?.legs.count ?? 0
        } else if flight?.segments.count == 2 {
            var counter = (flight!.segments.first!.legs.count + flight!.segments[1].legs.count)
            return counter
        }
        
        return (flight?.segments.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = flightDetailTableView.dequeueReusableCell(withIdentifier: "flightDetail", for: indexPath) as! FlightDetailTableViewCell
        let segments = flight!.segments
        let firstLegs = flight!.segments.first!.legs.count 
        var segment = segments.first!
        var isReturn = false
        var legNumber = indexPath.row
        //print("total:\(firstLegs)")
        //print("indexpath:", indexPath.row)
        if indexPath.row < firstLegs {
            segment = segments.first!
            isReturn = false
            legNumber = indexPath.row
        } else {
            segment = segments[1]
            isReturn = true
            legNumber = indexPath.row - firstLegs
        }
        cell.conf(segment: segment, legNumber: legNumber, isReturn: isReturn)
        //        if returnIsActive {
        //            cell.confReturn(flight: flight!)
        //        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "flightDetail") as! FlightDetailTableViewCell
        
        let segments = flight!.segments
        let firstLegs = flight!.segments.first!.legs.count
        var segment = segments.first!
        var legNumber = indexPath.row
        if indexPath.row < firstLegs {
            segment = segments.first!
            legNumber = indexPath.row
        } else {
            segment = segments[1]
            legNumber = indexPath.row - firstLegs
        }
        //var numberOfRows = 2
        let text1 = segment.legs[legNumber].departureAirport.name + ", " + segment.legs[legNumber].departureAirport.code
        let text2 = segment.legs[legNumber].arrivalAirport.name + ", " + segment.legs[legNumber].arrivalAirport.code
        var newHeight:CGFloat = 315 - 3 // HOW TO MAKE IT SET AUTOMATICALLY?
        if legNumber != 0 {
            newHeight -= (83.5 - 15 - 26)
        }
        // >23 Task for future: IT IS ONLY FOR IPHONE 11, SOMEHOW REDEFINE IT for IPADS it should work too!!!
        if text1.count > 23 {
            //numberOfRows += 1
            newHeight += 16.5
            if text1.count > 45 {
                newHeight += 16.5
            }
        }
        
        if text2.count > 23 {
            //numberOfRows += 1
            newHeight += 16.5
            if text2.count > 45 {
                newHeight += 16.5
            }
        }
        
        // 322 when text1=1 ; text2=2 rows
        // +14 when text2 = 2
        // +25 when text1 = 2
        
        return newHeight // Ensure a minimum height
    }
    
}

extension FlightDetailViewController: UISheetPresentationControllerDelegate{
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
            if sheetPresentationController.selectedDetentIdentifier == .large {
                sheetPresentationController.detents = [.large()] // Remove custom detent
            }
    }
}
