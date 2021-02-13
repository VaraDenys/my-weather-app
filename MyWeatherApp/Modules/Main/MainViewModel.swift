//
//  MainViewModel.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 31.01.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit
import Moya

class MainViewModel: ViewModel {
    
//    MARK: - Private
    
    private let indicatorsItems = IndicatorsType.allCases
    
    private let changeLocation: NSKeyValueObservation? = nil
    
//    MARK: - Public
    
    func indicatorsItemCount() -> Int{
        return indicatorsItems.count
    }
    
    func getIndicatorsItem(for indexPath: IndexPath) -> IndicatorsType {
        return indicatorsItems[indexPath.row]
    }
    
    func hourlyItemCount() -> Int {
        return HourlyType.data.count
    }
    
    func getHourlyItem(for indexPath: IndexPath) -> HourlyType {
        return HourlyType.data[indexPath.row]
    }
    
    func getDayForecastCount() -> Int {
        return DayForecastType.data.count
    }
    
    func getDaylyItem(for indexPath: IndexPath) -> DayForecastType {
        return DayForecastType.data[indexPath.row]
    }
    
    func resumeFetch(location: String) {
        let provider = MoyaProvider<AerisweatherForecastService>()
        provider.request(.getCurrentWeather(location: location)) { result in
            switch result {
            case .success(let response):
                let currentWeather = try? response.map(CurrentWeatherResponse.self)
                
                print("\(String(describing: currentWeather))")
                
                guard let current = currentWeather else { return }
                
                guard let locationName = current.valueResponse.first?.placeLocation.nameCity else { return }
                let topView = TopView()
                
                topView.configure(location: location, date: "sdad")
                
            case .failure(let error):
                debugPrint(error.errorDescription ?? "Unknown error")
            }
        }

    }
}
