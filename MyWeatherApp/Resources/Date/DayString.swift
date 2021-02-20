//
//  File.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 19.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct DayString {
    var dayOfTheWeek: Int
    
    func getStringDate() -> String {
        var day: String
        switch self.dayOfTheWeek {
        case 1:
            day = "Sun"
        case 2:
            day = "Mon"
        case 3:
            day = "Tue"
        case 4:
            day = "Wed"
        case 5:
            day = "Thu"
        case 6:
            day = "Fri"
        case 7:
            day = "Sat"
        default:
            day = ""
        }
        return day
    }
    
}
