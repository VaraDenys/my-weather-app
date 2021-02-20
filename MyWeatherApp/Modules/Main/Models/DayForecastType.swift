//
//  DayForecastType.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 04.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

struct DayForecastType {
    var dayOfTheWeek: String
    var temperature: String
    var image: UIImage
    
    static var data: [DayForecastType] = []
}
