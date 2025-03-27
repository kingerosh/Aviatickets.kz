//
//  PriceCollectionViewCell.swift
//  Aviatickets
//
//  Created by Ерош Айтжанов on 25.03.2025.
//

import UIKit

class PriceCollectionViewCell: UICollectionViewCell {
    
    private let paddedContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "15 may, thu"
        
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "20 696 ₸"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()

    }
    
    func setupUI() {
        contentView.addSubview(paddedContainer)
        contentView.backgroundColor = .systemGray6 // same as table.backgroudncolor in FlightsViewController
        
        paddedContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        [dateLabel, priceLabel].forEach {
            paddedContainer.addSubview($0)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func conf(data: DatumNew) {
        dateLabel.text = formatDayWithWeekday(from: data.departureDate)
        priceLabel.text = "\(formatPrice(data.price.units)) ₸"
    }
    
    func changeBackgroundColor(isSelected: Bool) {
        if isSelected {
            paddedContainer.backgroundColor = .systemBlue
            dateLabel.textColor = .white
            priceLabel.textColor = .white
        } else {
            paddedContainer.backgroundColor = .systemGray5
            dateLabel.textColor = .systemGray
            priceLabel.textColor = UIColor.label
        }
    }
    
    func cheapestPrice() {
        priceLabel.textColor = companyColor
    }
}
