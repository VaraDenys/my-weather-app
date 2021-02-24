//
//  MainMenuType.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 04.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit
import Alamofire

enum IndicatorsIconType: CaseIterable {
    
    case temperature
    case humidity
    case wind
    
    var icon: UIImage {
        switch self {
        case .temperature:
            return Images.temperatureIndicator.get()
        case .humidity:
            return Images.dropIndicator.get()
        case .wind:
            return Images.windIndicator.get()
        }
    }

}
