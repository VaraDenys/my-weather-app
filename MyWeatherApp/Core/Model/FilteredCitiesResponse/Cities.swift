//
//  Places.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 13.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct Cities: Decodable {
    var coordinate: CoordinateLatLong
    
    var city: PlaceInfo
    
    enum CodingKeys: String, CodingKey {
        case coordinate = "loc"
        case city = "place"
    }

}
