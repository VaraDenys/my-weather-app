//
//  MainMenuType.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 04.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit
import Alamofire

enum IndicatorsType: CaseIterable {
    case temperature
    case drop
    case wind
    
    var icon: UIImage {
        switch self {
        case .temperature:
            return Images.temperatureIndicator.get()
        case .drop:
            return Images.dropIndicator.get()
        case .wind:
            return Images.windIndicator.get()
        }
    }
    
    var indicatorValueTitle: String {
        switch self {
        case .temperature:
            return "27/19°"
        case .drop:
            return "33%"
        case .wind:
            return "5м/сек ↗"
        }
    }

}
