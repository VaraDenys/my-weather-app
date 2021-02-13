//
//  latLongCoordinate.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 11.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct latLongCoordinate: Decodable {
    var lat: Double
    var long: Double
    
    enum CodingKeys: String, CodingKey {
        case lat
        case long
    }
}
