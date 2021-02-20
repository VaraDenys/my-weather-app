//
//  ResultFilteredCities.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 13.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct ResultFilteredCities {
    var nameCities: String
    var nameCountry: String
    
    var lat: Double
    var long: Double
    
    static var data: [ResultFilteredCities] = []
}
