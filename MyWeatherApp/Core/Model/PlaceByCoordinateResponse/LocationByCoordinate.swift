//
//  LocationByCoordinate.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 18.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation


struct LocationByCoordinate: Decodable {
    var locationByCoordinate: NameCity
    var coordinateCorrect: CoordinateCorrect
    
    enum CodingKeys: String, CodingKey {
        case locationByCoordinate = "place"
        case coordinateCorrect = "loc"
    }
}

struct NameCity: Decodable {
    var name: String
}

struct CoordinateCorrect: Decodable {
    var lat: Double
    var long: Double
}
