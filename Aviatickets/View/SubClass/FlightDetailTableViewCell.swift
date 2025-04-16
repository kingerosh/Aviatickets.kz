//
//  FlightDetailTableViewCell.swift
//  Aviatickets
//
//  Created by Ерош Айтжанов on 15.03.2025.
//

import UIKit
import SnapKit

class FlightDetailTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var detailIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "airplane.departure")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = companyColor // Set the color here
        return view
    }()
    
    let circleView1: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 4 // Half of width/height to make it a perfect circle
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 2
        
        return view
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let circleView2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 4 // Half of width/height to make it a perfect circle
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 2
        
        return view
    }()
    
    lazy var mainCitiesLabel: UILabel = {
        let label = UILabel()
        label.text = "Almaty -- Astana"
        label.alpha = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mainRouteLabel: UILabel = {
        let label = UILabel()
        label.text = "5h 55m in route"
        label.alpha = 1
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let paddedContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var departureTimeLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var arrivalTimeLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var daysBetweenLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var carrierLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Scat Airlines"
        return title
    }()
    
    private lazy var routeLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "1h 5m"
        return title
    }()
    
    private lazy var classContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.backgroundColor = .systemGray
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var classLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .center
        title.textColor = .white
        //title.backgroundColor = .gray
        //title.layer.cornerRadius = 15
        title.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "economy"
        return title
    }()
    
    private lazy var flightNumberLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .right
        title.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Flight 719"
        return title
    }()
    
    private lazy var airportsLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var flightDurationLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var flightStopsLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var carrierLogoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 22 // Adjust according to size
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.clipsToBounds = true
        return view
    }()

    private lazy var carrierLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var fromTimeLabel:UILabel = {
        // takeoff
       let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "07:55"
        return title
    }()
    
    private lazy var fromDayLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "14 May"
        return title
    }()
    
    private lazy var fromCityLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Almaty"
        return title
    }()
    
    private lazy var fromAirportLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "Almaty, ALA, Terminal 1"
        return title
    }()
    
    private lazy var toTimeLabel:UILabel = {
        // landing
       let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "09:00"
        return title
    }()
    
    private lazy var toDayLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "14 May"
        return title
    }()
    
    private lazy var toCityLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Shymkent"
        return title
    }()
    
    private lazy var toAirportLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "Shymkent, CIT, Terminal A"
        return title
    }()
    
    private lazy var logoHandLuggageImageView:UIImageView = {
        let imageView = UIImageView()
        let smallConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular) // Adjust size
        imageView.image = UIImage(systemName: "handbag", withConfiguration: smallConfig)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var handLuggageLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 12, weight: .regular)
//        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "5 KG"
        return title
    }()
    
    private lazy var logoBaggageImageView:UIImageView = {
        let imageView = UIImageView()
        let smallConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular) // Adjust size
        imageView.image = UIImage(systemName: "bag", withConfiguration: smallConfig)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var baggageLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 12, weight: .regular)
//        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "0 KG"
        return title
    }()
    
    private lazy var transferImageView:UIImageView = {
        let imageView = UIImageView()
        let smallConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular) // Adjust size
        imageView.image = UIImage(systemName: "mappin.and.ellipse.circle", withConfiguration: smallConfig)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var transferLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Transfer in Shymkent 2h 55m"
        return title
    }()
    
    
    func setupUI() {
        [detailIconImageView, mainCitiesLabel, mainRouteLabel, paddedContainer].forEach {
            contentView.addSubview($0)
        }
        
        contentView.backgroundColor = .systemBackground // same as table.backgroudncolor in FlightsViewController
        
        detailIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalToSuperview().offset(15)
            make.width.height.equalTo(25)
        }
        
        mainCitiesLabel.snp.makeConstraints { make in
            make.top.equalTo(detailIconImageView.snp.top)
            make.leading.equalTo(detailIconImageView.snp.trailing).offset(10)
        }
        
        mainRouteLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainCitiesLabel)
            make.top.equalTo(mainCitiesLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        
        paddedContainer.snp.makeConstraints { make in
            make.top.equalTo(mainRouteLabel.snp.bottom).offset(15)
//            make.height.equalTo(250)
            make.leading.equalToSuperview().offset(15)
            make.bottom.trailing.equalToSuperview().offset(-15)
        }
        
//        [departureTimeLabel, airportsLabel, arrivalTimeLabel, daysBetweenLabel, carrierLogoContainer, flightDurationLabel, flightStopsLabel].forEach {
//            paddedContainer.addSubview($0)
//        }
        
        [carrierLogoContainer, carrierLabel, routeLabel, classContainer, flightNumberLabel, circleView1, dividerLineView, circleView2, fromTimeLabel, fromDayLabel, fromCityLabel, fromAirportLabel, toTimeLabel, toDayLabel, toCityLabel, toAirportLabel, logoBaggageImageView, baggageLabel, logoHandLuggageImageView, handLuggageLabel].forEach {
            paddedContainer.addSubview($0)
        }
        
        carrierLogoContainer.addSubview(carrierLogoImage)
        classContainer.addSubview(classLabel)
        
        carrierLogoContainer.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(15)
            make.width.height.equalTo(44)
        }
        
        carrierLogoImage.snp.makeConstraints { make in
            make.width.height.equalTo(28)
            make.center.equalToSuperview()
        }
        
        carrierLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(carrierLogoContainer.snp.trailing).offset(15)
        }
        
        routeLabel.snp.makeConstraints { make in
            make.top.equalTo(carrierLabel.snp.bottom).offset(5)
            make.leading.equalTo(carrierLabel)
        }
        
        classContainer.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(carrierLabel.snp.top)
            make.height.equalTo(20)
            make.width.equalTo(70)
        }
        
        classLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        flightNumberLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(routeLabel)
        }
        
        circleView1.snp.makeConstraints { make in
            make.centerX.equalTo(carrierLogoContainer.snp.centerX)
            make.top.equalTo(carrierLogoContainer.snp.bottom).offset(15)
            make.width.height.equalTo(8)
        }
        
        dividerLineView.snp.makeConstraints { make in
            make.centerX.equalTo(carrierLogoContainer.snp.centerX)
            make.top.equalTo(circleView1.snp.bottom)
            
            make.height.equalTo(55)
            make.width.equalTo(2)
        }
        
        circleView2.snp.makeConstraints { make in
            make.centerX.equalTo(carrierLogoContainer.snp.centerX)
            make.top.equalTo(dividerLineView.snp.bottom)
            make.width.height.equalTo(8)
        }
        
        //takeoff
        fromTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(circleView1.snp.centerY)
            make.leading.equalTo(carrierLabel.snp.leading)
        }
        
        fromDayLabel.snp.makeConstraints { make in
            make.top.equalTo(fromTimeLabel.snp.bottom).offset(5)
            make.leading.equalTo(fromTimeLabel.snp.leading)
        }
        
        fromCityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(fromTimeLabel.snp.centerY)
            make.leading.equalTo(paddedContainer.snp.centerX)
        }
        
        fromAirportLabel.snp.makeConstraints { make in
            make.leading.equalTo(fromCityLabel)
            make.top.equalTo(fromDayLabel.snp.top)
            make.trailing.equalToSuperview().offset(-36) // originX of dividerLineView = 36
        }
        
        // landing
        toTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(circleView2.snp.centerY)
            make.leading.equalTo(carrierLabel.snp.leading)
        }
        
        toDayLabel.snp.makeConstraints { make in
            make.top.equalTo(toTimeLabel.snp.bottom).offset(5)
            make.leading.equalTo(toTimeLabel.snp.leading)
        }
        
        toCityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(toTimeLabel.snp.centerY)
            make.leading.equalTo(paddedContainer.snp.centerX)
        }
        
        toAirportLabel.snp.makeConstraints { make in
            make.leading.equalTo(toCityLabel)
            make.trailing.equalToSuperview().offset(-36) // originX of dividerLineView = 36
            make.top.equalTo(toDayLabel.snp.top)
        }
        
        logoBaggageImageView.snp.makeConstraints { make in
            make.leading.equalTo(toCityLabel)
            make.top.equalTo(toAirportLabel.snp.bottom).offset(10)
        }
        
        baggageLabel.snp.makeConstraints { make in
            make.leading.equalTo(logoBaggageImageView.snp.trailing).offset(5)
            make.centerY.equalTo(logoBaggageImageView.snp.centerY)
        }
        
        logoHandLuggageImageView.snp.makeConstraints { make in
            make.leading.equalTo(toTimeLabel.snp.leading)
            make.top.equalTo(baggageLabel.snp.top)
        }
        
        handLuggageLabel.snp.makeConstraints { make in
            make.leading.equalTo(logoHandLuggageImageView.snp.trailing).offset(5)
            make.centerY.equalTo(logoHandLuggageImageView.snp.centerY)
        }

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
        
        //print("=========")
        var newHeight = transferImageView.frame.height
        newHeight += (5 + 5)
        //print(newHeight)
        
    }
    
    func conf(segment: FlightOfferSegment, legNumber: Int, isReturn: Bool) {
        
        if isReturn {
            detailIconImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
        if legNumber != 0 {
            [detailIconImageView, mainCitiesLabel, mainRouteLabel].forEach {
                $0.removeFromSuperview()
            }
            
            [transferImageView, transferLabel].forEach {
                contentView.addSubview($0)
            }
            
            transferImageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(5)
                make.leading.equalToSuperview().offset(35)
            }
            
            let transferTime = flightDuration(departure: segment.legs[legNumber-1].arrivalTime, arrival: segment.legs[legNumber].departureTime)
            transferLabel.text = "Transfer in \(segment.legs[legNumber].departureAirport.cityName) \(transferTime ?? "")"
            
            transferLabel.snp.makeConstraints { make in
                make.top.equalTo(transferImageView.snp.top)
                make.leading.equalTo(transferImageView.snp.trailing).offset(20)
            }
            
            paddedContainer.snp.remakeConstraints { make in
                make.top.equalTo(transferImageView.snp.bottom).offset(20)
    //            make.height.equalTo(250)
                make.leading.equalToSuperview().offset(15)
                make.bottom.trailing.equalToSuperview().offset(-15)
            }
            
        }
        
        
        
        let carrierLogoURL = segment.legs[legNumber].carriersData.first?.logo
        NetworkManager.shared.loadImage(imageUrl: carrierLogoURL!) { image in
            self.carrierLogoImage.image = image
        }
        
        mainCitiesLabel.text = segment.departureAirport.cityName + " -- " + segment.arrivalAirport.cityName
        mainRouteLabel.text = flightDuration(departure: segment.departureTime, arrival: segment.arrivalTime)
        
        routeLabel.text = flightDuration(departure: segment.legs[legNumber].departureTime, arrival: segment.legs[legNumber].arrivalTime)
        carrierLabel.text = segment.legs[legNumber].carriersData.first?.name
        flightNumberLabel.text = "Flight " + String(segment.legs[legNumber].flightInfo.flightNumber)
//        if let flightNumber = segment.legs.first?.flightInfo.flightNumber {
//            flightNumberLabel.text = "Flight " + String(flightNumber) // or "\(flightNumber)"
//        } else {
//            flightNumberLabel.text = "N/A" // or any default value
//        }
        
        fromTimeLabel.text = formatTime(from: segment.legs[legNumber].departureTime)
        fromCityLabel.text = segment.legs[legNumber].departureAirport.cityName
        fromAirportLabel.text = segment.legs[legNumber].departureAirport.name + ", " + segment.legs[legNumber].departureAirport.code
        fromDayLabel.text = formatDay(from: segment.legs[legNumber].departureTime)
        
        toTimeLabel.text = formatTime(from: segment.legs[legNumber].arrivalTime)
        toCityLabel.text = segment.legs[legNumber].arrivalAirport.cityName
        toAirportLabel.text = segment.legs[legNumber].arrivalAirport.name + ", " + segment.legs[legNumber].arrivalAirport.code
        toDayLabel.text = formatDay(from: segment.legs[legNumber].arrivalTime)
        
        
        if fromAirportLabel.text!.count > 23 {
            var newHeight = 55 + 16.5
            fromAirportLabel.numberOfLines = 2
            if fromAirportLabel.text!.count > 45 {
                fromAirportLabel.numberOfLines = 3
                newHeight += 16.5
            }
            
            dividerLineView.snp.updateConstraints { make in
                make.height.equalTo(newHeight)
            }
        }
        
        if toAirportLabel.text!.count > 45 {
            toAirportLabel.numberOfLines = 3
        } else if toAirportLabel.text!.count > 23 {
            toAirportLabel.numberOfLines = 2
        }
    
    }

}
