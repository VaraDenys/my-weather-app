//
//  DaylyForecastResponse.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 20.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation


struct DaylyForecastResponse: Decodable {
    let success: Bool
    let error: String?
    
    let response: [ResponseDayly]?
}
