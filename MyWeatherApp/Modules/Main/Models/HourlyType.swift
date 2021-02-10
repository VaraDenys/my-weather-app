//
//  HourlyType.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 04.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

//enum HourlyType: CaseIterable {
//
//    case hour
//    case image
//    case temperature
//}

struct HourlyType {
    var hour: String
    var image: UIImage
    var temperature: String
    
    static let data: [HourlyType] = [
        HourlyType(hour: "17:00", image: Images.cloudyDay.get(), temperature: "27°"),
        HourlyType(hour: "18:00", image: Images.cloudyDay.get(), temperature: "27°"),
        HourlyType(hour: "19:00", image: Images.cloudyDay.get(), temperature: "27°"),
        HourlyType(hour: "20:00", image: Images.cloudyDay.get(), temperature: "27°"),
        HourlyType(hour: "21:00", image: Images.cloudyDay.get(), temperature: "27°"),
        HourlyType(hour: "22:00", image: Images.cloudyDay.get(), temperature: "27°"),
        HourlyType(hour: "23:00", image: Images.cloudyDay.get(), temperature: "27°"),
        HourlyType(hour: "24:00", image: Images.cloudyDay.get(), temperature: "27°")
    ]
}
