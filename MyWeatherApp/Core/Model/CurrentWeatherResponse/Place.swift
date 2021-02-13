//
//  Place.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 11.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct Place: Decodable {
    var nameCity: String
    var countryName: String
    
    enum CodingKeys: String, CodingKey {
        case nameCity = "name"
        case countryName = "country"
    }
    
}
