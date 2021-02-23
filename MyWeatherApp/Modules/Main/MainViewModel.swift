//
//  MainViewModel.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 31.01.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit
import Moya
import Alamofire

class MainViewModel: ViewModel {
    
// MARK: - Properties
    
    private let service = WeatherService()
    
    var lat: Double?
    
    var long: Double?
    
    var hourlyForecast: [HourlyType] = []
    
    var daylyForecast: [DayForecastType] = []
    
    var onDidChangeCurrentValues: ((TopViewType) -> Void)!
    
    var onDidChangeHourlyForecast: (() -> Void)!
    
    var onDidChangeDaylyForecast: (() -> Void)!
    
// MARK: - Init
    
    init(latitude: Double?, longitude: Double?) {
        super.init()
        
        guard let lat = latitude, let long = longitude else { return }
        
        self.lat = lat
        self.long = long
    }
    
// MARK: - Public func
    
    func hourlyItemCount() -> Int {
        return hourlyForecast.count
    }
    
    func getHourlyItem(for indexPath: IndexPath) -> HourlyType {
        return hourlyForecast[indexPath.row]
    }
    
    func getDayForecastCount() -> Int {
        return daylyForecast.count
    }
    
    func getDaylyItem(for indexPath: IndexPath) -> DayForecastType {
        return daylyForecast[indexPath.row]
    }
    
    func resumeFetch(lat: Double, long: Double) {
        
        self.service.getCurrentWeather(lat: lat, long: long) { result in
            self.onDidChangeCurrentValues(result)
        }
        
        service.getHourlyForecast(lat: lat, long: long) { result in
            self.hourlyForecast = result
            self.onDidChangeHourlyForecast()
        }

        service.getDaylyForecast(lat: lat, long: long) { result in
            self.daylyForecast = result
            self.onDidChangeDaylyForecast()
        }
    }
}
