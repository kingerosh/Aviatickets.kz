import Foundation
import Alamofire
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://booking-com15.p.rapidapi.com/api/v1/flights/searchFlights"
    private let multiURL = "https://booking-com15.p.rapidapi.com/api/v1/flights/searchFlightsMultiStops"
    private let airportsURL = "https://booking-com15.p.rapidapi.com/api/v1/flights/searchDestination"
    private let pricesURL = "https://booking-com15.p.rapidapi.com/api/v1/flights/getMinPrice"
    private let pricesMultiURL = "https://booking-com15.p.rapidapi.com/api/v1/flights/getMinPriceMultiStops"
    
    private let headers: HTTPHeaders = [
        "x-rapidapi-host": "booking-com15.p.rapidapi.com",
        "x-rapidapi-key": "33472ff036mshc44c9f8a422e518p133860jsn95cea37ede7c"
        // 28b17fa475msh3a0d241e8b61d7cp1e08b6jsnc770818855b5
        // 921414a5e7msh7f5ecf1b16d51bap103b07jsn0ec04b2984ae
        // d4a594aff1mshb07dc0badf6df9ap13333ajsn1fe6e5846dae
        // b2456efd67msh2f337923d5e0ec5p18fd9cjsna51487a93257
        // d4543a80d5msh369b292b2f89126p147ad4jsn7cc4def015e5
        
        // 33472ff036mshc44c9f8a422e518p133860jsn95cea37ede7c
    ]
    
    private init() {} // Singleton
    
    func searchFlights(from: String, to: String, departureDate: String, completion: @escaping (Result<SearchedFlights, Error>) -> Void) {
        
        let params: [String: Any] = [
            "fromId": "\(from).AIRPORT",
            "toId": "\(to).AIRPORT",
            "departDate": departureDate,
            "pageNo": 1,
            "adults": 1,
            "children": 0,
            "sort": "BEST",
            "cabinClass": "ECONOMY",
            "currency_code": "KZT"
        ]
        
        AF.request(baseURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    // 🔍 Проверка JSON перед парсингом
                    //jsonString
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("📜 RAW JSON Response:\n", jsonString)
                        //print("📜 RAW JSON Response:\n", jsonString)
                    }
                    
                    do {
                        let decodedData = try JSONDecoder().decode(SearchedFlights.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        print("❌ JSON Decoding Error:", error)
                        
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    print("❌ Request Error:", error.localizedDescription)
                    completion(.failure(error))
                }
            }
    }
    
    func pricesFlights(from: String, to: String, departureDate: String, completion: @escaping (Result<Prices, Error>) -> Void) {
        
        let params: [String: Any] = [
            "fromId": "\(from).AIRPORT",
            "toId": "\(to).AIRPORT",
            "departDate": departureDate,
            "pageNo": 1,
            "adults": 1,
            "children": 0,
            "sort": "BEST",
            "cabinClass": "ECONOMY",
            "currency_code": "KZT"
        ]
        
        AF.request(pricesURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    // 🔍 Проверка JSON перед парсингом
                    //jsonString
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("📜 RAW JSON Response:\n", jsonString)
                        //print("📜 RAW JSON Response:\n", jsonString)
                    }
                    
                    do {
                        let decodedData = try JSONDecoder().decode(Prices.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        print("❌ JSON Decoding Error:", error)
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    print("❌ Request Error:", error.localizedDescription)
                    completion(.failure(error))
                }
            }
    }
    
    func searchMultiFlights(from: String, to: String, departureDate: String, returnDate: String, completion: @escaping (Result<SearchedFlights, Error>) -> Void) {
        
        let legs = "[{'fromId':'\(from).AIRPORT','toId':'\(to).AIRPORT','date':'\(departureDate)'},{'fromId':'\(to).AIRPORT','toId':'\(from).AIRPORT','date':'\(returnDate)'}]"
        
        let params: [String: Any] = [
            "legs": legs,
            "pageNo": 1,
            "adults": 1,
            "children": 0,
            "sort": "BEST",
            "cabinClass": "ECONOMY",
            "currency_code": "KZT"
        ]
        
        AF.request(multiURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    // 🔍 Проверка JSON перед парсингом
                    //jsonString
                    if let jsonString = String(data: data, encoding: .utf8) {
                        //print("📜 RAW JSON Response:\n")
                        print("📜 RAW JSON Response:\n", jsonString)
                    }
                    
                    do {
                        let decodedData = try JSONDecoder().decode(SearchedFlights.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        print("❌ JSON Decoding Error:", error)
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    print("❌ Request Error:", error.localizedDescription)
                    completion(.failure(error))
                }
            }
    }
    
    func pricesMultiFlights(from: String, to: String, departureDate: String, returnDate: String, completion: @escaping (Result<Prices, Error>) -> Void) {
        
        let legs = "[{'fromId':'\(from).AIRPORT','toId':'\(to).AIRPORT','date':'\(departureDate)'},{'fromId':'\(to).AIRPORT','toId':'\(from).AIRPORT','date':'\(returnDate)'}]"
        
        let params: [String: Any] = [
            "legs": legs,
            "pageNo": 1,
            "adults": 1,
            "children": 0,
            "sort": "BEST",
            "cabinClass": "ECONOMY",
            "currency_code": "KZT"
        ]
        
        AF.request(pricesMultiURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    // 🔍 Проверка JSON перед парсингом
                    //jsonString
                    if let jsonString = String(data: data, encoding: .utf8) {
                        //print("📜 RAW JSON Response:\n")
                        print("📜 RAW JSON Response:\n", jsonString)
                    }
                    
                    do {
                        let decodedData = try JSONDecoder().decode(Prices.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        print("❌ JSON Decoding Error:", error)
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    print("❌ Request Error:", error.localizedDescription)
                    completion(.failure(error))
                }
            }
    }
    
    func searchAirports(query: String, completion: @escaping (Result<Airports, Error>) -> Void) {
        
        let params: [String: String] = ["query": query]
        
        AF.request(airportsURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    // 🔍 Проверка JSON перед парсингом
                    //jsonString
                    if let _ = String(data: data, encoding: .utf8) {
                        print("📜 RAW JSON Response:\n")
                        //print("📜 RAW JSON Response:\n", jsonString)
                    }
                    
                    do {
                        let decodedData = try JSONDecoder().decode(Airports.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        print("❌ JSON Decoding Error:", error)
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    print("❌ Request Error:", error.localizedDescription)
                    completion(.failure(error))
                }
            }
    }
    
    func loadImage(imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        AF.request(imageUrl).responseData { response in
            switch response.result {
            case .success(let data):
                let image = UIImage(data: data)
                completion(image)
            case .failure(let error):
                print("❌ Ошибка загрузки изображения:", error.localizedDescription)
                completion(nil)
            }
        }
    }
}
