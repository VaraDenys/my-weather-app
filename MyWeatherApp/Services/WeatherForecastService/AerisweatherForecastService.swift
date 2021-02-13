//
//  Moya.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 11.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit
import Alamofire
import Moya

struct ConstantsServise {
    static var domainURL: URL? = URL(string: "https://api.aerisapi.com")
    static let clientId: String = "Zcy35wNMT5Bf3N1qXwKou"
    static let clientSecret: String = "WZJVrbhHakZq4QArb4luDHJgYX03EKNvE2WwHOCD"
}

enum  AerisweatherForecastService {
    case getCurrentWeather(location: String)
    case getSearchCity(searchText: String)
}


extension AerisweatherForecastService: TargetType {
    
    var baseURL: URL {
        guard let url = ConstantsServise.domainURL else { fatalError("invalid domain URL") }
        return url
    }
    
    var path: String {
        switch self {
        case .getCurrentWeather(location: let location):
            return "/conditions/\(location)"
        case .getSearchCity(searchText: let searchCity):
            return "/places/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCurrentWeather(location: _), .getSearchCity(searchText: _):
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getCurrentWeather(location: _), .getSearchCity(searchText: _):
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .getCurrentWeather(location: _):
            return .requestParameters(
                parameters: ["client_id": "\(ConstantsServise.clientId)",
                    "client_secret": "\(ConstantsServise.clientSecret)"],
                encoding: URLEncoding.default)
        case .getSearchCity(searchText: let searchText):
            return .requestParameters(
                parameters: [
                    "limit": "10",
                    "sort": "pop:1,haszip:-1",
                    "query": "name:^\(searchText)",
                    "client_id": ConstantsServise.clientId,
                    "client_secret": ConstantsServise.clientSecret],
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

#warning("delete than")
//struct  ShopListResponse: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case response
//    }
//    let response: [Place]
//}
//
//struct Place: Decodable {
//    var place: Name
//
//    enum CodingKeys: String, CodingKey {
//        case place
//    }
//}
//
//struct Name: Decodable {
//    var name: String
//
//    enum CodingKeys: String, CodingKey {
//        case name
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.name = try container.decode(String.self, forKey: .name)
//    }
//}

