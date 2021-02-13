//
//  Period.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 11.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct Period: Decodable {
    var dateTimeISO: String
    var currentTemp: Double
    
    enum CodingKeys: String, CodingKey {
        case dateTimeISO
        case currentTemp = "tempC"
    }
}
