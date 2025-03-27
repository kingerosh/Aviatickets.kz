//
//  Airports.swift
//  Aviatickets
//
//  Created by Ерош Айтжанов on 02.03.2025.
//

import Foundation

// MARK: - Airports
struct Airports: Codable {
    let status: Bool
    let message: String
    let timestamp: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: String
    let type: TypeEnum
    let name, code: String
    let city, cityName: String?
    let regionName, country, countryName: String?
    let countryNameShort: String?
    let photoURI: String?
    let distanceToCity: DistanceToCity?
    let parent, region: String?

    enum CodingKeys: String, CodingKey {
        case id, type, name, code, city, cityName, regionName, country, countryName, countryNameShort
        case photoURI = "photoUri"
        case distanceToCity, parent, region
    }
}

// MARK: - DistanceToCity
struct DistanceToCity: Codable {
    let value: Double
    let unit: Unit
}

enum Unit: String, Codable {
    case km = "km"
}

enum TypeEnum: String, Codable {
    case airport = "AIRPORT"
    case city = "CITY"
}
