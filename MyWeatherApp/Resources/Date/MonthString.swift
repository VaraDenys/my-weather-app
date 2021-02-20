//
//  MonthString.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 19.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct MonthString {
    var month: Int
    
    func getString() -> String {
        var string: String
        switch month {
        case 1:
            string = "january"
        case 2:
            string = "february"
        case 3:
            string = "March"
        case 4:
            string = "April"
        case 5:
            string = "May"
        case 6:
            string = "june"
        case 7:
            string = "july"
        case 8:
            string = "august"
        case 9:
            string = "september"
        case 10:
            string = "october"
        case 11:
            string = "november"
        case 12:
            string = "december"
        default:
            string = ""
        }
        return string
    }
}
