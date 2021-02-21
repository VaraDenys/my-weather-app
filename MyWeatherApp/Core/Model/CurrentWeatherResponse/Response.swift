//
//  Response.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 11.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct Response: Decodable {
    var locationCoordinate: LatLongCoordinate
    var placeLocation: Place
    var periods: [Period]
    
    enum CodingKeys: String, CodingKey {
        case locationCoordinate = "loc"
        case placeLocation = "place"
        case periods = "periods"
    }
}
