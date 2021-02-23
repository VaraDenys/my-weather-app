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

struct ConstantsEndpoint {
    static let domainURL: URL? = URL(string: "https://api.aerisapi.com")
    static let clientId: String = "Zcy35wNMT5Bf3N1qXwKou"
    static let clientSecret: String = "WZJVrbhHakZq4QArb4luDHJgYX03EKNvE2WwHOCD"
}

struct ParamsEndpoint {
    static let placeCoordinate = "p"
    static let limit = "limit"
    static let filter = "filter"
    static let from = "from"
    static let to = "to"
    static let skip = "skip"
    static let limitPeriods = "plimit"
    static let skipPeriods = "pskip"
    static let fieldsResult = "fields"
    static let query = "query"
    static let clientId = "client_id"
    static let clientSecret = "client_secret"
}

enum  AerisweatherForecastAPIEndpoint {
    case getCurrentWeather(latitude: Double, longitude: Double)
    case getSearchCity(location: String)
    case getPlaceByCoordinate(latitude: Double, longitude: Double)
    case getForecastDayly(latitude: Double, longitude: Double)
    case getForecastHourly(latitude: Double, longitude: Double)
}


extension AerisweatherForecastAPIEndpoint: TargetType {
    
    var baseURL: URL {
        guard let url = ConstantsEndpoint.domainURL else { fatalError("invalid domain URL") }
        return url
        
    }
    
    var path: String {
        switch self {
        case .getCurrentWeather(latitude: let lat, longitude: let lon):
            return "/conditions/\(String(format: "%.2f", lat) + "," + String(format: "%.2f", lon))"
        case .getSearchCity(location: _):
            return "/places/search"
        case .getPlaceByCoordinate(latitude: _, longitude: _):
            return "/places/closest"
        case .getForecastDayly(latitude: let lat, longitude: let lon):
            return "/forecasts/\(lat),\(lon)"
        case .getForecastHourly(latitude: let lat, longitude: let lon):
            return "/forecasts/\(lat),\(lon)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCurrentWeather(location: _),
             .getSearchCity(location: _),
             .getPlaceByCoordinate(latitude: _, longitude: _),
             .getForecastDayly(latitude: _, longitude: _),
             .getForecastHourly(latitude: _, longitude: _):
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getCurrentWeather(location: _),
             .getSearchCity(location: _),
             .getPlaceByCoordinate(latitude: _, longitude: _),
             .getForecastDayly(latitude: _, longitude: _),
             .getForecastHourly(latitude: _, longitude: _):
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .getCurrentWeather(location: _):
            return .requestParameters(
                parameters: [
                    ParamsEndpoint.clientId: ConstantsEndpoint.clientId,
                    ParamsEndpoint.clientSecret: ConstantsEndpoint.clientSecret
                ],
                encoding: URLEncoding.default)
        case .getSearchCity(location: let searchText):
            return .requestParameters(
                parameters: [
                    ParamsEndpoint.limit: "10",
                    ParamsEndpoint.filter: "ppl",
                    ParamsEndpoint.query: "name:^\(searchText)",
                    ParamsEndpoint.clientId: ConstantsEndpoint.clientId,
                    ParamsEndpoint.clientSecret: ConstantsEndpoint.clientSecret
                ],
                encoding: URLEncoding.default)
            
        case .getPlaceByCoordinate(latitude: let latitude, longitude: let longitude):
            return .requestParameters(
                parameters: [
                    ParamsEndpoint.placeCoordinate: "\(latitude),\(longitude)",
                    ParamsEndpoint.clientId: ConstantsEndpoint.clientId,
                    ParamsEndpoint.clientSecret: ConstantsEndpoint.clientSecret
                ],
                encoding: URLEncoding.default)
            
        case .getForecastDayly(latitude: _, longitude: _):
            return .requestParameters(
                parameters: [
                    ParamsEndpoint.fieldsResult: "interval,periods.maxTempC,periods.minTempC,periods.icon,periods.timestamp",
                    ParamsEndpoint.limit: "7",
                    ParamsEndpoint.clientId: ConstantsEndpoint.clientId,
                    ParamsEndpoint.clientSecret: ConstantsEndpoint.clientSecret
                ],
                encoding: URLEncoding.default)
            
        case .getForecastHourly(latitude: _, longitude: _):
            return .requestParameters(
                parameters: [
                    "format": "json",
                    ParamsEndpoint.filter: "1hr",
                    ParamsEndpoint.limit: "24",
                    ParamsEndpoint.fieldsResult: "interval,periods.validTime,periods.maxTempC,periods.icon",
                    ParamsEndpoint.clientId: ConstantsEndpoint.clientId,
                    ParamsEndpoint.clientSecret: ConstantsEndpoint.clientSecret
                ],
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

