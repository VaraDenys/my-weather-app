//
//  ResponseDayly.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 20.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct ResponseDayly: Decodable {
    let interval: String
    let periods: [PeriodDay]
}
