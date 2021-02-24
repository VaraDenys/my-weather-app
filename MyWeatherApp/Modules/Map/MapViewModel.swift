//
//  MapViewModel.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 17.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit
import Moya

class MapViewModel: ViewModel {
    
// MARK: - Properties
    
    private let service = WeatherService()
    
    var onDidChangeLocation: (([Double]) -> Void)!

// MARK: - Public func
    
    func requestLocationByCoordinate(lat: Double, long: Double) {
        
        service.getPlaceByCoordinate(lat: lat, long: long) { (array) in
            
            self.onDidChangeLocation(array)
        }
    }
}
