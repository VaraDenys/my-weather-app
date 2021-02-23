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
    
    private let provider = MoyaProvider<AerisweatherForecastAPIEndpoint>()
    
    var onDidChangeLocation: (([Double]) -> Void)?

    func requestLocationByCoordinate(latitude: Double, longitude: Double) {
        
        provider.request(.getPlaceByCoordinate(latitude: latitude, longitude: longitude)) { [weak self] (result) in
            
            switch result {
            case .success(let response):
                
                let res = try? response.map(PlacesByCoordinate.self)

                guard let location = res?.response?.first?.locationByCoordinate.name else { return }
                
                guard let lat = res?.response?.first?.coordinateCorrect.lat else { return }
                guard let long = res?.response?.first?.coordinateCorrect.long else { return }
                
                self?.onDidChangeLocation?([lat, long])
                
                debugPrint("first request \(location)")
                
            case .failure(let error):
                
                debugPrint(error.errorDescription ?? "Unknown error")
                
                return
            }
        }

    }
    
}
