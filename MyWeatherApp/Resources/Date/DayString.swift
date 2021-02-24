//
//  File.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 19.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct DateString {
    
    static func weekDay(dayNumber: Int) -> String {
        switch dayNumber {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return"Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return ""
        }
    }
    
    static func month(monthNumber: Int) -> String {
        switch monthNumber {
        case 1:
            return "january"
        case 2:
            return "february"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "june"
        case 7:
            return "july"
        case 8:
            return "august"
        case 9:
            return "september"
        case 10:
            return "october"
        case 11:
            return "november"
        case 12:
            return "december"
        default:
            return ""
        }
    }
}
