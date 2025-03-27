//
//  ViewController.swift
//  Aviatickets
//
//  Created by Ерош Айтжанов on 21.01.2025.
//

import UIKit
import SnapKit
let companyColor: UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)

func showErrorAlert(message: String, in viewController: UIViewController) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        if let navigationController = viewController.navigationController {
            navigationController.popViewController(animated: true) // Go back if in navigation stack
        } else {
            viewController.dismiss(animated: true) // Dismiss if presented modally
        }
    }
    
    alert.addAction(okAction)
    viewController.present(alert, animated: true)
}

func formatTime(from dateTimeString: String) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // Формат входящей строки
    formatter.locale = Locale(identifier: "en_US_POSIX") // Гарантия правильного парсинга
    formatter.timeZone = TimeZone.current // Использует текущий часовой пояс

    if let date = formatter.date(from: dateTimeString) {
        formatter.dateFormat = "HH:mm" // Новый формат (только время)
        return formatter.string(from: date)
    }
    
    return nil // Вернёт nil, если не смог распарсить строку
}

func formatDay(from dateTimeString: String) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // Input format
    formatter.locale = Locale(identifier: "en_US_POSIX") // Ensures correct parsing
    formatter.timeZone = TimeZone.current // Uses the current timezone

    if let date = formatter.date(from: dateTimeString) {
        formatter.dateFormat = "d MMM" // Output format: day (no leading zero) and short month
        return formatter.string(from: date)
    }
    
    return nil // Returns nil if parsing fails
}

func formatDayWithWeekday(from dateTimeString: String) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd" // Adjusted input format
    formatter.locale = Locale(identifier: "en_US_POSIX") // Ensures correct parsing
    formatter.timeZone = TimeZone.current // Uses the current timezone

    if let date = formatter.date(from: dateTimeString) {
        formatter.dateFormat = "d MMM, EEE" // Output format: day, short month, short weekday
        return formatter.string(from: date).lowercased() // Convert to lowercase if needed
    }
    
    return nil // Returns nil if parsing fails
}

func flightDuration(departure: String, arrival: String) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone.current
    
    guard let departureDate = formatter.date(from: departure),
          let arrivalDate = formatter.date(from: arrival) else {
        return nil
    }
    
    let duration = arrivalDate.timeIntervalSince(departureDate) // Разница в секундах
    
    let componentsFormatter = DateComponentsFormatter()
    componentsFormatter.allowedUnits = [.hour, .minute] // Указываем, что нужно часы и минуты
    componentsFormatter.unitsStyle = .short // Формат, например, "2h 30m"

    return componentsFormatter.string(from: duration) // Преобразуем в строку
}

func formatPrice(_ price: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = " "  // Устанавливаем пробел как разделитель тысяч
    return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
}

// MARK: - ViewController

class ViewController: UIViewController, CitySearchDelegate {

    var lastActiveTextField: UITextField?
    var depatureCity: String?
    var arrivalCity: String?
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Aviatickets.kz"
        label.alpha = 1
        label.textColor = companyColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let citiesContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let citiesDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let fromTextField: PaddedTextField = {
        let textField = PaddedTextField()
        //textField.placeholder = "From"
        textField.attributedPlaceholder = NSAttributedString(string: "From", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        //textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return textField
    }()
    
    lazy var fromCodeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.alpha = 1
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
        
    let toTextField: PaddedTextField = {
        let textField = PaddedTextField()
        //textField.placeholder = "To"
        textField.attributedPlaceholder = NSAttributedString(string: "To", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        //textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return textField
    }()
    
    lazy var toCodeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.alpha = 1
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    let datesContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let datesDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let departureDateTextField: UITextField = {
        let textField = UITextField()
        //textField.placeholder = "Departure Date"
        textField.attributedPlaceholder = NSAttributedString(string: "Departure Date", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        //textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        return textField
    }()

    let returnDateTextField: UITextField = {
        let textField = UITextField()
        //textField.placeholder = "Return Date"
        textField.attributedPlaceholder = NSAttributedString(string: "Return Date", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        //textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return textField
    }()
    
    let datePicker = UIDatePicker()
    
    let findFlightsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Find Flights", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = companyColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    let flipAirportsButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold) // Adjust size
        let image = UIImage(systemName: "arrow.right.arrow.left.circle.fill", withConfiguration: largeConfig)
                                                                                                            
        button.setImage(image, for: .normal)
        button.tintColor = companyColor
        //button.setTitleColor(.white, for: .normal)
        //button.backgroundColor = .blue
        //button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    func setTodayDate() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        departureDateTextField.text = formatter.string(from: datePicker.minimumDate!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupUI()
        setupDatePicker()
        setTodayDate()
        
        findFlightsButton.addTarget(self, action: #selector(findFlightsTapped(_:)), for: .touchUpInside)
        flipAirportsButton.addTarget(self, action: #selector(flipAirportsTapped(_:)), for: .touchUpInside)
        
        fromTextField.addTarget(self, action: #selector(openCitySearch(_:)), for: .editingDidBegin)
        fromTextField.rightView = fromCodeLabel
        fromTextField.rightViewMode = .always
        
        toTextField.addTarget(self, action: #selector(openCitySearch(_:)), for: .editingDidBegin)
        toTextField.rightView = toCodeLabel
        toTextField.rightViewMode = .always
        
        // DEFAULT FOR TESTING (below)!!!!!!!!!
        
        fromTextField.text = "Aktobe, Kazakhstan"
        depatureCity = "Aktobe"
        fromCodeLabel.text = "AKX"
        
        toTextField.text = "Almaty, Kazakhstan"
        arrivalCity = "Almaty"
        toCodeLabel.text = "ALA"
        
//        NetworkManager.shared.pricesFlights(from: "ALA", to: "AKX", departureDate: "2025-05-28") { result in
//            do {
//                let data = try result.get() // Extract data safely
//                print(data.data)
//                
//            } catch {
//                print("❌ Error fetching flights: \(error.localizedDescription)")
//            }
//        }
        
//        NetworkManager.shared.pricesMultiFlights(from: "ALA", to: "AKX", departureDate: "2025-05-28", returnDate: "2025-06-02") { result in
//            do {
//                let data = try result.get() // Extract data safely
//                print(data.data)
//                
//            } catch {
//                print("❌ Error fetching flights: \(error.localizedDescription)")
//            }
//        }
        
        
    
        
    
//        NetworkManager.shared.searchMultiFlights(from: "AKX", to: "ALA", departureDate: "2025-05-25", returnDate: "2025-05-28") { result in
//            do {
//                let multiFlightData = try result.get()
//                print(multiFlightData.data.flightOffers.first?.segments.first?.arrivalAirport ?? "0")
//                print(multiFlightData.data.flightOffers.first?.segments[1].arrivalAirport ?? "0")
//            } catch {
//                print("Error multi flight: \(error.localizedDescription)")
//            }
//        }
        // Do any additional setup after loading the view.
    
    }
    
    func setupUI() {
        [mainLabel, citiesContainerView, flipAirportsButton, datesContainerView, findFlightsButton].forEach {
            view.addSubview($0)
        }
        
        [fromTextField, citiesDividerView, toTextField].forEach {
            citiesContainerView.addSubview($0)
        }
        
        [departureDateTextField, datesDividerView, returnDateTextField].forEach {
            datesContainerView.addSubview($0)
        }
        
        
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        citiesContainerView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(flipAirportsButton.snp.leading).offset(-15)
            make.height.equalTo(120)
        }
        
        fromTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        citiesDividerView.snp.makeConstraints { make in
            make.top.equalTo(fromTextField.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(1)
            //make.width.equalTo(100)
        }
        
        toTextField.snp.makeConstraints { make in
            make.top.equalTo(citiesDividerView.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        flipAirportsButton.snp.makeConstraints { make in
            make.centerY.equalTo(citiesContainerView.snp.centerY)
//            make.leading.equalTo(fromTextField.snp.trailing).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        flipAirportsButton.transform = CGAffineTransform(rotationAngle: .pi / 2)
        
        datesContainerView.snp.makeConstraints { make in
            make.top.equalTo(toTextField.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(60)
        }
        
        departureDateTextField.snp.makeConstraints { make in
            make.top.bottom.equalTo(datesContainerView)
            make.leading.equalTo(datesContainerView.snp.leading).offset(10)
            make.trailing.equalTo(datesContainerView.snp.centerX).offset(-2)
            make.height.equalTo(50)
            
        }
        
        datesDividerView.snp.makeConstraints { make in
            make.leading.equalTo(departureDateTextField.snp.trailing)
            make.trailing.equalTo(returnDateTextField.snp.leading).offset(-10)
            make.top.bottom.equalToSuperview()
            //make.width.equalTo(2)
        }
        
        returnDateTextField.snp.makeConstraints { make in
            make.top.bottom.trailing.equalTo(datesContainerView)
            make.leading.equalTo(datesContainerView.snp.centerX).offset(12) // 10 + 2(width of datesDividerView)
            make.height.equalTo(50)
        }
        
        findFlightsButton.snp.makeConstraints { make in
            make.top.equalTo(datesContainerView.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(60)
        }
        
    }
    
    func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date() // Prevent selecting past dates

        // Create toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Flexible space to push buttons to the right
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // "Clear" button
        let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearButtonPressed))
        
        // "Done" button
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        
        // Add buttons to the toolbar
        toolbar.setItems([clearButton, flexibleSpace, doneButton], animated: true)

        // Assign date picker & toolbar to text fields
        departureDateTextField.inputView = datePicker
        departureDateTextField.inputAccessoryView = toolbar

        returnDateTextField.inputView = datePicker
        returnDateTextField.inputAccessoryView = toolbar
    }

    // Action for "Clear" button
    @objc func clearButtonPressed() {
        if departureDateTextField.isFirstResponder {
            departureDateTextField.text = ""
        } else if returnDateTextField.isFirstResponder {
            returnDateTextField.text = ""
        }
        view.endEditing(true) // Dismiss keyboard & picker
    }
    

    @objc func doneButtonPressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        if departureDateTextField.isFirstResponder {
            departureDateTextField.text = formatter.string(from: datePicker.date)
        } else if returnDateTextField.isFirstResponder {
            returnDateTextField.text = formatter.string(from: datePicker.date)
        }

        view.endEditing(true) // Dismiss keyboard & picker
    }

    func convertToAPIFormat(dateString: String) -> String? {
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd MMM yyyy"
        displayFormatter.locale = Locale(identifier: "en_US_POSIX")

        let apiFormatter = DateFormatter()
        apiFormatter.dateFormat = "yyyy-MM-dd"
        apiFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = displayFormatter.date(from: dateString) {
            return apiFormatter.string(from: date)
        }
        
        return nil // Return nil if conversion fails
    }
    
    @objc func flipAirportsTapped(_ sender: UIButton) {
        let from = fromTextField.text
        let fromCode = fromCodeLabel.text
        fromTextField.text = toTextField.text
        fromCodeLabel.text = toCodeLabel.text
        
        toTextField.text = from
        toCodeLabel.text = fromCode
    }
    
    @objc func findFlightsTapped(_ sender: UIButton) {
        print("working")
        guard let from = fromCodeLabel.text else {
            return
        }
        
        guard let to = toCodeLabel.text else {
            return
        }
        
        guard let departureDate = convertToAPIFormat(dateString: departureDateTextField.text!) else {
            showErrorAlert(message: "Depature date is empty. Please choose date and press done.", in: self)
            print("not depart")
            return
        }
        
        print(departureDate)
        //let returnDate = returnDateTextField.text ?? ""
        
        func setReturnDate() throws -> String {
            guard let returnDateTextFieldText = convertToAPIFormat(dateString: returnDateTextField.text!) else {
                throw NSError(domain: "", code: 0, userInfo: nil)
            }
            return returnDateTextFieldText
        }
        
        var returnDate = ""
        
        do {
            returnDate = try setReturnDate()
            print(returnDate)
        } catch {
            returnDate = ""
            print("not return")
        }
        
        let loadingVC = LoadingViewController(from: from, to: to, departureDate: departureDate, returnDate: returnDate, depatureCity: self.depatureCity!, arrivalCity: self.arrivalCity!)
        
        if from != to {
            
            if !from.isEmpty && !to.isEmpty && !departureDate.isEmpty {
                self.navigationController?.pushViewController(loadingVC, animated: true)
            } else {
                print("Something is empty!")
            }
        } else {
            showErrorAlert(message: "You chose same city for depature and arrival. Please change it.", in: self)
            print("SAME CITY ERROR!")
        }
        
        
        
        
    }
    
    @objc func openCitySearch(_ sender: UITextField) {
        lastActiveTextField = sender
        let searchVC = CitySearchViewController()
        searchVC.delegate = self
        print(sender == fromTextField)
        if sender == fromTextField {
            searchVC.searchMainLabel.text = "From"
        } else if sender == toTextField {
            searchVC.searchMainLabel.text = "To"
        }
        
        searchVC.modalPresentationStyle = .automatic
        
        
        if let sheet = searchVC.sheetPresentationController {
            
            
            sheet.detents = [.large()] // Enables draggable sizes
            sheet.prefersGrabberVisible = true // Shows the mini-line
            
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            
        }
        
        present(searchVC, animated: true)
    }
    
    func didSelectCity(city: String, country: String, airportCode: String) {
        print("Selected City: \(city), country: \(country), Airport Code: \(airportCode)")
        
        guard let activeTextField = lastActiveTextField else {
            print("⚠️ No active text field stored")
            return
        }
        
        if activeTextField == fromTextField {
            fromTextField.text = city + ", " + country
            depatureCity = city
            fromCodeLabel.text = airportCode
            fromTextField.rightView = fromCodeLabel // Ensure rightView updates
        } else if activeTextField == toTextField {
            toTextField.text = city + ", " + country
            arrivalCity = city
            toCodeLabel.text = airportCode
            toTextField.rightView = toCodeLabel
        }
    }
}

class PaddedTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 30) // Increase right padding

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.rightViewRect(forBounds: bounds)
        return originalRect.offsetBy(dx: -10, dy: 0) // Move rightView to the left
    }
}
