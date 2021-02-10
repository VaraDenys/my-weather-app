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
    
    static let data: [DayForecastType] = [
        DayForecastType(dayOfTheWeek: "ПН", temperature: "27°/19°", image: Images.rain.get()),
        DayForecastType(dayOfTheWeek: "ВТ", temperature: "27°/19°", image: Images.rain.get()),
        DayForecastType(dayOfTheWeek: "СР", temperature: "27°/19°", image: Images.rain.get()),
        DayForecastType(dayOfTheWeek: "ЧТ", temperature: "27°/19°", image: Images.rain.get()),
        DayForecastType(dayOfTheWeek: "ПТ", temperature: "27°/19°", image: Images.rain.get()),
        DayForecastType(dayOfTheWeek: "СБ", temperature: "27°/19°", image: Images.rain.get()),
        DayForecastType(dayOfTheWeek: "ВС", temperature: "27°/19°", image: Images.rain.get()),
    ]
}
