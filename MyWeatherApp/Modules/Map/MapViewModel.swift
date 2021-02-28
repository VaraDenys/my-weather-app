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
    
    var onDidChangeLocation: ((_ lat: Double, _ long: Double) -> Void)!
    
    var onDidError: ((MyErrorType) -> Void)!

// MARK: - Public func
    
    func requestLocationByCoordinate(lat: Double, long: Double) {
        
        service.getPlaceByCoordinate(lat: lat, long: long) { [weak self] result in
            
            switch result {
                
            case .success((let latitude, let longitude)):
                
                self?.onDidChangeLocation(latitude, longitude)
                
            case .failure(let error):
                
                self?.onDidError(error)
            }
        }
    }
}
