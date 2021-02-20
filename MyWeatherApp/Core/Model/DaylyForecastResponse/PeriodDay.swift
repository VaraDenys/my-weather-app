//
//  File.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 20.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct PeriodDay: Decodable {
    let maxTempC, minTempC: Int?
    let icon: String?
    let timestamp: Int
}
