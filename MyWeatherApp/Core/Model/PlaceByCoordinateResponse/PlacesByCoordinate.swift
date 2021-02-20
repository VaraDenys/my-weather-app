//
//  PlacesByCoordinate.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 18.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation


struct RsponseByCoordinate: Decodable {
    var successResponse: Bool
    var errorMessage: String?
    
    var response: [LocationByCoordinate]?
    
    enum CodingKeys: String, CodingKey {
        case successResponse = "success"
        case errorMessage = "error"
        case response = "response"
    }
}
