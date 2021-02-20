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
    
    private let provider = MoyaProvider<AerisweatherForecastService>()
    
    var onDidChangeLocation: ((String) -> Void)?

    func requestLocationByCoordinate(latitude: Double, longitude: Double) {
        
        provider.request(.getPlaceByCoordinate(latitude: latitude, longitude: longitude)) { [weak self] (result) in
            
            switch result {
            case .success(let response):
                
                let res = try? response.map(RsponseByCoordinate.self)

                guard let location = res?.response?.first?.locationByCoordinate.name else { return }
                
                self?.onDidChangeLocation?(location)
                
                debugPrint("first request \(location)")
                
            case .failure(let error):
                
                debugPrint(error.errorDescription ?? "Unknown error")
                
                return
            }
        }

    }
    
}
