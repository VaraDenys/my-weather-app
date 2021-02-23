//
//  HourlyForecastResponse.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 21.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct HourlyForecastResponse: Decodable {
    let success: Bool
    let error: String?

    let response: [PeriodsHourly]?
}

struct PeriodsHourly: Decodable {
    let interval: String?
    let periods: [PeriodHour]?
}

struct PeriodHour: Decodable {
    let validTime: String
    let maxTempC: Int
    let icon: String
}

