//
//  FlightTableViewCell.swift
//  Aviatickets
//
//  Created by Ерош Айтжанов on 20.02.2025.
//

import UIKit
import SnapKit

class FlightTableViewCell: UITableViewCell {
    
    private let paddedContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
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
        view.layer.cornerRadius = 25 // Adjust according to size
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
    
    private lazy var carrierLogoContainer2: UIView = {
        let view = UIView()
        view.alpha = 0
        
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25 // Adjust according to size
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.clipsToBounds = true
        return view
    }()

    private lazy var carrierLogoImage2: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // RETURN all.alpha = 0
    
    private lazy var departureTimeLabelReturn:UILabel = {
       let title = UILabel()
        title.alpha = 0
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var arrivalTimeLabelReturn:UILabel = {
       let title = UILabel()
        title.alpha = 0
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var daysBetweenLabelReturn:UILabel = {
       let title = UILabel()
        title.alpha = 0
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var airportsLabelReturn:UILabel = {
       let title = UILabel()
        title.alpha = 0
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var flightDurationLabelReturn:UILabel = {
       let title = UILabel()
        title.alpha = 0
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var flightStopsLabelReturn:UILabel = {
       let title = UILabel()
        title.alpha = 0
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var carrierLogoContainerReturn: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25 // Adjust according to size
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.clipsToBounds = true
        return view
    }()

    private lazy var carrierLogoImageReturn: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var carrierLogoContainer2Return: UIView = {
        let view = UIView()
        view.alpha = 0 // by default
        
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25 // Adjust according to size
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.clipsToBounds = true
        return view
    }()

    private lazy var carrierLogoImage2Return: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0 // by default
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    // PRICE
    
    private let priceContainer: UIView = {
        let view = UIView()
        view.backgroundColor = companyColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath(
            roundedRect: priceContainer.bounds,
            byRoundingCorners: [.topLeft, .bottomRight], // Specify corners
            cornerRadii: CGSize(width: 10, height: 10) // Set radius
        )
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        priceContainer.layer.mask = mask
    }
    
    private lazy var priceLabel:UILabel = {
       let title = UILabel()
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        contentView.addSubview(paddedContainer)
        contentView.backgroundColor = .systemGray6 // same as table.backgroudncolor in FlightsViewController
        
        paddedContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        [departureTimeLabel, airportsLabel, arrivalTimeLabel, daysBetweenLabel, carrierLogoContainer2, carrierLogoContainer, flightDurationLabel, flightStopsLabel, departureTimeLabelReturn, airportsLabelReturn, arrivalTimeLabelReturn, daysBetweenLabelReturn, carrierLogoContainer2Return, carrierLogoContainerReturn, flightDurationLabelReturn, flightStopsLabelReturn, priceContainer].forEach {
            paddedContainer.addSubview($0)
        }
        
        carrierLogoContainer.addSubview(carrierLogoImage)
        carrierLogoContainer2.addSubview(carrierLogoImage2)
        carrierLogoContainerReturn.addSubview(carrierLogoImageReturn)
        carrierLogoContainer2Return.addSubview(carrierLogoImage2Return)
        priceContainer.addSubview(priceLabel)
        
        departureTimeLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
        }
        
        airportsLabel.snp.makeConstraints { make in
            make.leading.equalTo(departureTimeLabel.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        arrivalTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(airportsLabel.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        daysBetweenLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.leading.equalTo(arrivalTimeLabel.snp.trailing).offset(2)
        }
        
        carrierLogoContainer2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-35)
            make.width.height.equalTo(50)
        }
        
        carrierLogoImage2.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.center.equalToSuperview()
        }
        
        carrierLogoContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
        
        carrierLogoImage.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.center.equalToSuperview()
        }
        
        flightDurationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(departureTimeLabel.snp.bottom).offset(10)
        }
        
        flightStopsLabel.snp.makeConstraints { make in
            make.leading.equalTo(flightDurationLabel.snp.trailing).offset(10)
            make.top.equalTo(departureTimeLabel.snp.bottom).offset(10)
        }
        
        // RETURN
        
        departureTimeLabelReturn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(flightStopsLabel.snp.bottom).offset(15) // MAIN PADDING from DEPATURE to RETURN
        }
        
        airportsLabelReturn.snp.makeConstraints { make in
            make.leading.equalTo(departureTimeLabelReturn.snp.trailing).offset(10)
            make.top.equalTo(departureTimeLabelReturn.snp.top)
        }
        
        arrivalTimeLabelReturn.snp.makeConstraints { make in
            make.leading.equalTo(airportsLabelReturn.snp.trailing).offset(10)
            make.top.equalTo(departureTimeLabelReturn.snp.top)
        }
        
        daysBetweenLabelReturn.snp.makeConstraints { make in
            make.top.equalTo(departureTimeLabelReturn.snp.top).offset(-1)
            make.leading.equalTo(arrivalTimeLabelReturn.snp.trailing).offset(2)
        }
        
        carrierLogoContainer2Return.snp.makeConstraints { make in
            make.top.equalTo(departureTimeLabelReturn.snp.top)
            make.trailing.equalToSuperview().offset(-35)
            make.width.height.equalTo(50)
        }
        
        carrierLogoImage2Return.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.center.equalToSuperview()
        }
        
        carrierLogoContainerReturn.snp.makeConstraints { make in
            make.top.equalTo(departureTimeLabelReturn.snp.top)
            make.trailing.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
        
        carrierLogoImageReturn.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.center.equalToSuperview()
        }
        
        flightDurationLabelReturn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(departureTimeLabelReturn.snp.bottom).offset(10)
        }
        
        flightStopsLabelReturn.snp.makeConstraints { make in
            make.leading.equalTo(flightDurationLabelReturn.snp.trailing).offset(10)
            make.top.equalTo(departureTimeLabelReturn.snp.bottom).offset(10)
        }
        
        
        
        // PRICE
        
        priceContainer.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func conf(flight: FlightOffer) {
        let segment = flight.segments.first!

        if let formattedDeparture = formatTime(from: segment.departureTime),
           let formattedArrival = formatTime(from: segment.arrivalTime) {
            departureTimeLabel.text = formattedDeparture
            arrivalTimeLabel.text = formattedArrival
        }
        
        if let duration = flightDuration(departure: segment.departureTime, arrival: segment.arrivalTime) {
            flightDurationLabel.text = duration
        }
        
        let daysBetween = daysBetween(departure: segment.departureTime, arrival: segment.arrivalTime)
        if daysBetween != 0 {
            daysBetweenLabel.text = "+" + String(daysBetween!) + "d"
        }
        
        let flightStops = segment.legs.count
        if flightStops == 1 {
            flightStopsLabel.text = "nonstop"
            
            let carrierLogoURL = segment.legs.first?.carriersData.first?.logo
            NetworkManager.shared.loadImage(imageUrl: carrierLogoURL!) { image in
                self.carrierLogoImage.image = image
            }
            
            carrierLogoContainer2.alpha = 0
            carrierLogoImage2.alpha = 0
        } else if flightStops == 2 {
            flightStopsLabel.text = "1 stop"
            carrierLogoContainer2.alpha = 1
            carrierLogoImage2.alpha = 1
            let carrierLogoURL1 = segment.legs.first?.carriersData.first?.logo
            let carrierLogoURL2 = segment.legs[1].carriersData.first?.logo
            NetworkManager.shared.loadImage(imageUrl: carrierLogoURL1!) { image1 in
                self.carrierLogoImage2.image = image1
            }
            NetworkManager.shared.loadImage(imageUrl: carrierLogoURL2!) { image2 in
                self.carrierLogoImage.image = image2
            }
        } else {
            flightStopsLabel.text = "\(flightStops) stops"
            
            let carrierLogoURL = segment.legs.first?.carriersData.first?.logo
            NetworkManager.shared.loadImage(imageUrl: carrierLogoURL!) { image in
                self.carrierLogoImage.image = image
            }
            
            carrierLogoContainer2.alpha = 0
            carrierLogoImage2.alpha = 0
        }
        
        
        airportsLabel.text = (segment.departureAirport.code) + " --- " + (segment.arrivalAirport.code)
        if let _ = flight.priceBreakdown {
            priceLabel.text = formatPrice(flight.priceBreakdown!.total.units) + " " + flight.priceBreakdown!.total.currencyCode.rawValue
        } else {
            priceLabel.text = "N/A"
        }
    }
    
    func confReturn(flight: FlightOffer) {
        let segment = flight.segments[1]
        
        [departureTimeLabelReturn, airportsLabelReturn, arrivalTimeLabelReturn, daysBetweenLabelReturn, carrierLogoContainerReturn, flightDurationLabelReturn, flightStopsLabelReturn, carrierLogoImageReturn].forEach {
            ($0).alpha = 1
        }

        if let formattedDeparture = formatTime(from: segment.departureTime),
           let formattedArrival = formatTime(from: segment.arrivalTime) {
            departureTimeLabelReturn.text = formattedDeparture
            arrivalTimeLabelReturn.text = formattedArrival
        }
        
        if let duration = flightDuration(departure: segment.departureTime, arrival: segment.arrivalTime) {
            flightDurationLabelReturn.text = duration
        }
        
        let daysBetween = daysBetween(departure: segment.departureTime, arrival: segment.arrivalTime)
        if daysBetween != 0 {
            daysBetweenLabelReturn.text = "+" + String(daysBetween!) + "d"
        }
        
        let flightStops = segment.legs.count
        if flightStops == 1 {
            flightStopsLabelReturn.text = "nonstop"
            
            let carrierLogoURL = segment.legs.first?.carriersData.first?.logo
            NetworkManager.shared.loadImage(imageUrl: carrierLogoURL!) { image in
                self.carrierLogoImageReturn.image = image
            }
            
            carrierLogoContainer2Return.alpha = 0
            carrierLogoImage2Return.alpha = 0
        } else if flightStops == 2 {
            flightStopsLabelReturn.text = "1 stop"
            carrierLogoContainer2Return.alpha = 1
            carrierLogoImage2Return.alpha = 1
            let carrierLogoURL1 = segment.legs.first?.carriersData.first?.logo
            let carrierLogoURL2 = segment.legs[1].carriersData.first?.logo
            NetworkManager.shared.loadImage(imageUrl: carrierLogoURL1!) { image1 in
                self.carrierLogoImage2Return.image = image1
            }
            NetworkManager.shared.loadImage(imageUrl: carrierLogoURL2!) { image2 in
                self.carrierLogoImageReturn.image = image2
            }
        } else {
            flightStopsLabelReturn.text = "\(flightStops) stops"
            
            let carrierLogoURL = segment.legs.first?.carriersData.first?.logo
            NetworkManager.shared.loadImage(imageUrl: carrierLogoURL!) { image in
                self.carrierLogoImageReturn.image = image
            }
            
            carrierLogoContainer2Return.alpha = 0
            carrierLogoImage2Return.alpha = 0
        }
        
        
        airportsLabelReturn.text = (segment.departureAirport.code) + " --- " + (segment.arrivalAirport.code)
//        if let _ = flight.priceBreakdown {
//            priceLabel.text = formatPrice(flight.priceBreakdown!.total.units) + " " + flight.priceBreakdown!.total.currencyCode.rawValue
//        } else {
//            priceLabel.text = "N/A"
//        }
    }
    
    func daysBetween(departure: String, arrival: String) -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"  // Format matching your date strings
        formatter.locale = Locale(identifier: "en_US_POSIX") // Ensures correct parsing
        formatter.timeZone = TimeZone.current  // Uses the current timezone
        
        guard let departureDate = formatter.date(from: departure),
              let arrivalDate = formatter.date(from: arrival) else {
            return nil  // Return nil if parsing fails
        }
        
        let calendar = Calendar.current
        let departureDay = calendar.startOfDay(for: departureDate)
        let arrivalDay = calendar.startOfDay(for: arrivalDate)
        
        let daysBetween = calendar.dateComponents([.day], from: departureDay, to: arrivalDay).day ?? 0
        return daysBetween
    }
}
