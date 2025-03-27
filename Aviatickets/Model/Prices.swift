//
//  Prices.swift
//  Aviatickets
//
//  Created by Ерош Айтжанов on 24.03.2025.
//

import Foundation

// MARK: - Prices
struct Prices: Codable {
    let status: Bool
    let message: String
    let timestamp: Int
    let data: [DatumNew]
}

// MARK: - Datum
struct DatumNew: Codable {
    let departureDate: String
    let searchDates: [String]
    let offsetDays: Int
    let isCheapest: Bool
    let price, priceRounded: Price
}

// MARK: - Price
struct Price: Codable {
    let currencyCode: String
    let units, nanos: Int
}


