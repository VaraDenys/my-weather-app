//
//  Images.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 31.01.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

public enum Images: String {
    case locationIcon = "location-icon"
    case targetIcon = "target-icon"
    
    case cloudyDay = "cloudy-day"
    case rain = "rain"
    
    case temperatureIndicator = "thermometer"
    case dropIndicator = "drop"
    case windIndicator = "wind"
    
    case searchBarLoupe = "loupe"
    case backButton = "left-arrow"
    
    func get() -> UIImage {
        guard let image = UIImage(named: self.rawValue) else {
            fatalError("Failed attempt create image with name \(rawValue)")
        }
        return image
    }
    
}
