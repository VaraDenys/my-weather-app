//
//  File.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 11.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct CurrentWeatherResponse: Decodable {
    var successResponse: Bool
    var errorMessage: String?
    
    var valueResponse: [Response]
    
    enum CodingKeys: String, CodingKey {
        case successResponse = "success"
        case errorMessage = "error"
        case valueResponse = "response"
    }
}
