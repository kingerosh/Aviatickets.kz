// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchedFlights = try? JSONDecoder().decode(SearchedFlights.self, from: jsonData)

import Foundation

// MARK: - SearchedFlights
struct SearchedFlights: Codable {
    let status: Bool
    let message: String
    let timestamp: Int
    let data: DataClass
}

struct APIError: Codable {
    let code: String
    let requestId: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let aggregation: Aggregation?
    let flightOffers: [FlightOffer?]?
    let flightDeals: [FlightDeal]?
    let atolProtectedStatus, searchID: String?
    let banners: [JSONAny]?
    let displayOptions: DisplayOptions?
    let isOffersCabinClassExtended: Bool?
    let cabinClassExtension: CabinClassExtension?
    let searchCriteria: SearchCriteria?
    let baggagePolicies: [BaggagePolicy]?
    let priceAlertStatus: PriceAlertStatus?
    let error: APIError?

    enum CodingKeys: String, CodingKey {
        case aggregation, flightOffers, flightDeals, atolProtectedStatus
        case searchID = "searchId"
        case banners, displayOptions, isOffersCabinClassExtended, cabinClassExtension, searchCriteria, baggagePolicies, priceAlertStatus, error
    }
}

// MARK: - Aggregation
struct Aggregation: Codable {
    let totalCount, filteredTotalCount: Int
    let stops: [Stop]
    let airlines: [Airline]
    let departureIntervals: [DepartureInterval]
    let flightTimes: [FlightTime]
    let shortLayoverConnection: ShortLayoverConnection?
    let durationMin, durationMax: Int
    let minPrice, minRoundPrice, minPriceFiltered: MinPrice
    let baggage: [Baggage]
    let budget, budgetPerAdult: Budget
    let duration: [Duration]
    let filtersOrder: [String]
}

// MARK: - Airline
struct Airline: Codable {
    let name: String
    let logoURL: String
    let iataCode: String
    let count: Int
    let minPrice: MinPrice

    enum CodingKeys: String, CodingKey {
        case name
        case logoURL = "logoUrl"
        case iataCode, count, minPrice
    }
}

// MARK: - MinPrice
struct MinPrice: Codable {
    let currencyCode: CurrencyCode
    let units, nanos: Int
}

enum CurrencyCode: String, Codable {
    case kzt = "KZT"
}



// MARK: - Baggage
struct Baggage: Codable {
    let paramName: String
    let count: Int
    let enabled: Bool
    let baggageType: String
}

// MARK: - Budget
struct Budget: Codable {
    let paramName: String
    let min, max: MinPrice
}

// MARK: - DepartureInterval
struct DepartureInterval: Codable {
    let start, end: String
}

// MARK: - Duration
struct Duration: Codable {
    let min, max: Int
    let durationType: String
    let enabled: Bool
    let paramName: String
}

// MARK: - FlightTime
struct FlightTime: Codable {
    let arrival, departure: [Arrival]
}

// MARK: - Arrival
struct Arrival: Codable {
    let start, end: String
    let count: Int
}

// MARK: - ShortLayoverConnection
struct ShortLayoverConnection: Codable {
    let count: Int
}

// MARK: - Stop
struct Stop: Codable {
    let numberOfStops, count: Int
    let minPrice, minPriceRound: MinPrice
}

// MARK: - BaggagePolicy
struct BaggagePolicy: Codable {
    let code: String
    let name: String
    let url: String
}

// MARK: - CabinClassExtension
struct CabinClassExtension: Codable {
}

// MARK: - DisplayOptions
struct DisplayOptions: Codable {
    let brandedFaresShownByDefault, directFlightsOnlyFilterIgnored, hideFlexiblePricesBanner: Bool
}

// MARK: - FlightDeal
struct FlightDeal: Codable {
    let key, offerToken: String
    let price, priceRounded: MinPrice
    let travellerPrices: [TravellerPrice]
}

// MARK: - TravellerPrice
struct TravellerPrice: Codable {
    let travellerPriceBreakdown: PriceBreakdown?
    let travellerReference: String
    let travellerType: TravellerType
}

// MARK: - PriceBreakdown
struct PriceBreakdown: Codable {
    let total, baseFare, fee, tax: MinPrice
    let totalRounded: MinPrice?
    let moreTaxesAndFees: CabinClassExtension?
    let discount, totalWithoutDiscount: MinPrice
    let totalWithoutDiscountRounded: MinPrice?
    let carrierTaxBreakdown: [CarrierTaxBreakdown]?
}

// MARK: - CarrierTaxBreakdown
struct CarrierTaxBreakdown: Codable {
    let carrier: Carrier
    let avgPerAdult: MinPrice
    let avgPerInfant: MinPrice?
}

// MARK: - Carrier
struct Carrier: Codable {
    let name: String
    let code: String
    let logo: String
}

enum TravellerType: String, Codable {
    case adult = "ADULT"
    case kid = "KID"
}

// MARK: - FlightOffer
struct FlightOffer: Codable {
    let token: String
    let segments: [FlightOfferSegment]
    let priceBreakdown: PriceBreakdown?
    let travellerPrices: [TravellerPrice]
    let priceDisplayRequirements: [JSONAny]
    let pointOfSale: String?
    let tripType: String?
    let posMismatch: PosMismatch?
    let includedProductsBySegment: [[IncludedProductsBySegment]]
    let includedProducts: IncludedProducts
    let extraProducts: [ExtraProduct?]?
    let offerExtras: OfferExtras?
    let ancillaries: Ancillaries?
    let brandedFareInfo: BrandedFareInfo?
    let appliedDiscounts: [JSONAny]
    let offerKeyToHighlight: String
    let extraProductDisplayRequirements: CabinClassExtension?
    let unifiedPriceBreakdown: UnifiedPriceBreakdown?
    let requestableBrandedFares: Bool?
}

// MARK: - Ancillaries
struct Ancillaries: Codable {
    let checkedInBaggage: CheckedInBaggage?
    let flexibleTicket: AncillariesFlexibleTicket?
}

// MARK: - CheckedInBaggage
struct CheckedInBaggage: Codable {
    let airProductReference: AirProductReference
    let options: [Option]
}

enum AirProductReference: String, Codable {
    case nA = "n/a"
}

// MARK: - Option
struct Option: Codable {
    let luggageAllowance: LuggageAllowance?
    let priceBreakdown: PriceBreakdown?
    let travellers: [String]
    let preSelected: Bool
}

// MARK: - LuggageAllowance
struct LuggageAllowance: Codable {
    let luggageType: LuggageType
    let ruleType: String?
    let maxPiece: Int
    let maxWeightPerPiece: Double?
    let massUnit: String?
    let sizeRestrictions: SizeRestrictions?
}

enum LuggageType: String, Codable {
    case checkedIn = "CHECKED_IN"
    case hand = "HAND"
    case personalItem = "PERSONAL_ITEM"
}



// MARK: - SizeRestrictions
struct SizeRestrictions: Codable {
    let maxLength, maxWidth, maxHeight: Double
    let sizeUnit: String?
}

// MARK: - AncillariesFlexibleTicket
struct AncillariesFlexibleTicket: Codable {
    let airProductReference: AirProductReference
    let travellers: [String]
    let priceBreakdown: PriceBreakdown?
    let preSelected: Bool
    let recommendation: Recommendation
    let supplierInfo: SupplierInfo?
}

// MARK: - Recommendation
struct Recommendation: Codable {
    let recommended: Bool
    let confidence: Confidence
}

enum Confidence: String, Codable {
    case unknownLevel = "UNKNOWN_LEVEL"
}

// MARK: - SupplierInfo
struct SupplierInfo: Codable {
    let name: String?
    let termsURL, privacyPolicyURL: String?

    enum CodingKeys: String, CodingKey {
        case name
        case termsURL = "termsUrl"
        case privacyPolicyURL = "privacyPolicyUrl"
    }
}



// MARK: - BrandedFareInfo
struct BrandedFareInfo: Codable {
    let fareName: String?
    let cabinClass: String?
    let features: [Feature]
    let fareAttributes: [JSONAny]
    let nonIncludedFeaturesRequired: Bool
    let nonIncludedFeatures: [JSONAny]
}



// MARK: - Feature
struct Feature: Codable {
    let featureName: FeatureName
    let category: Category
    let code: FeatureCode
    let label: String?
    let availability: Availability
}

enum Availability: String, Codable {
    case included = "INCLUDED"
}

enum Category: String, Codable {
    case baggage = "BAGGAGE"
}

enum FeatureCode: String, Codable {
    case bk01 = "BK01"
    case bk02 = "BK02"
    case bk03 = "BK03"
}

enum FeatureName: String, Codable {
    case cabinBaggage = "CABIN_BAGGAGE"
    case checkBaggage = "CHECK_BAGGAGE"
    case personalBaggage = "PERSONAL_BAGGAGE"
}



// MARK: - ExtraProduct
struct ExtraProduct: Codable {
    let type: String?
    let priceBreakdown: PriceBreakdown?
}



// MARK: - IncludedProducts
struct IncludedProducts: Codable {
    let areAllSegmentsIdentical: Bool
    let segments: [[IncludedProductsSegment]]
}

// MARK: - IncludedProductsSegment
struct IncludedProductsSegment: Codable {
    let luggageType: LuggageType
    let maxPiece: Int
    let maxWeightPerPiece: Double?
    let massUnit: String?
    let sizeRestrictions: SizeRestrictions?
    let piecePerPax: Int
    let ruleType: String?
}

// MARK: - IncludedProductsBySegment
struct IncludedProductsBySegment: Codable {
    let travellerReference: String
    let travellerProducts: [TravellerProduct]
}

// MARK: - TravellerProduct
struct TravellerProduct: Codable {
    let type: TravellerProductType
    let product: LuggageAllowance?
}

enum TravellerProductType: String, Codable {
    case cabinBaggage = "cabinBaggage"
    case checkedInBaggage = "checkedInBaggage"
    case personalItem = "personalItem"
}

// MARK: - OfferExtras
struct OfferExtras: Codable {
    let flexibleTicket: OfferExtrasFlexibleTicket?
}

// MARK: - OfferExtrasFlexibleTicket
struct OfferExtrasFlexibleTicket: Codable {
    let airProductReference: AirProductReference
    let travellers: [String]
    let recommendation: Recommendation
    let priceBreakdown: PriceBreakdown?
    let supplierInfo: SupplierInfo?
}



// MARK: - PosMismatch
struct PosMismatch: Codable {
    let detectedPointOfSale: String?
    let isPOSMismatch: Bool
    let offerSalesCountry: String?
}

// MARK: - FlightOfferSegment
struct FlightOfferSegment: Codable {
    let departureAirport, arrivalAirport: Airport
    let departureTime, arrivalTime: String
    let legs: [Leg]
    let totalTime: Int
    let travellerCheckedLuggage: [TravellerCheckedLuggage]
    let travellerCabinLuggage: [TravellerCabinLuggage]
    let isAtolProtected, showWarningDestinationAirport, showWarningOriginAirport: Bool
    let isVirtualInterlining: Bool?
}

// MARK: - Airport
struct Airport: Codable {
    let type: String
    let code: String
    let name: String
    let city: String
    let cityName: String
    let country: String
    let countryName: String
    let province: String?
}


// MARK: - Leg
struct Leg: Codable {
    let departureTime, arrivalTime: String
    let departureAirport, arrivalAirport: Airport
    let cabinClass: String?
    let flightInfo: FlightInfo
    let carriers: [String]
    let carriersData: [Carrier]
    let totalTime: Int
    let flightStops, amenities: [JSONAny]
    let arrivalTerminal, departureTerminal: String?
    let vi: Vi?
}

// MARK: - FlightInfo
struct FlightInfo: Codable {
    let facilities: [JSONAny]
    let flightNumber: Int
    let planeType: String
    let carrierInfo: CarrierInfo
}

// MARK: - CarrierInfo
struct CarrierInfo: Codable {
    let operatingCarrier, marketingCarrier: String
    let operatingCarrierDisclosureText: String
}

// MARK: - Vi
struct Vi: Codable {
    let protected, baggageCollection: Bool
}

// MARK: - TravellerCabinLuggage
struct TravellerCabinLuggage: Codable {
    let travellerReference: String
    let luggageAllowance: LuggageAllowance
    let personalItem: Bool?
}

// MARK: - TravellerCheckedLuggage
struct TravellerCheckedLuggage: Codable {
    let travellerReference: String
    let luggageAllowance: LuggageAllowance
}

// MARK: - UnifiedPriceBreakdown
struct UnifiedPriceBreakdown: Codable {
    let price: MinPrice
    let items: [Item]
    let addedItems: [JSONAny]
}

// MARK: - Item
struct Item: Codable {
    let scope: Scope?
    let id: ID
    let title: Title
    let price: MinPrice
    let items: [Item]
}

enum ID: String, Codable {
    case flightAdult = "flight_adult"
    case flightAdultBasefare = "flight_adult-basefare"
    case flightAdultTax = "flight_adult-tax"
    case flightInfant = "flight_infant"
    case flightInfantBasefare = "flight_infant-basefare"
    case flightInfantTax = "flight_infant-tax"
}

enum Scope: String, Codable {
    case flightAdult = "FLIGHT_ADULT"
    case flightInfant = "FLIGHT_INFANT"
}

enum Title: String, Codable {
    case adult1 = "Adult (1)"
    case flightFare = "Flight fare"
    case infant1 = "Infant (1)"
    case taxesAndAirlineFees = "Taxes and airline fees"
}

// MARK: - PriceAlertStatus
struct PriceAlertStatus: Codable {
    let isEligible, isSearchEligible, isBlockoutEligible: Bool
}

// MARK: - SearchCriteria
struct SearchCriteria: Codable {
    let cabinClass: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is JSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = JSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is JSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is JSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                    self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try JSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: JSONCodingKey.self)
                    try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try JSONAny.encode(to: &container, value: self.value)
            }
    }
}
