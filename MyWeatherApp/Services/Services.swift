//
//  Services.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 11.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

public final class Services {

//    MARK: - Singletone
    
    public static let instance = Services()
    
//    MARK: - Public services
    
    lazy var weatherForecast = AerisweatherForecastService.self
}
