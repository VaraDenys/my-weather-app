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
    private var lat: Double?
    private var long: Double?
    private var topViewType: TopViewType?
    private var hourlyForecast: [HourlyType] = []
    private var daylyForecast: [DayForecastType] = []
    var onDidChangeValues: (() -> Void)!
    var onDidError: ((MyErrorType) -> Void)!
    
    // MARK: - Init
    
    init(latitude: Double?, longitude: Double?) {
        super.init()
        
        guard let lat = latitude, let long = longitude else { return }
        
        self.lat = lat
        self.long = long
    }
    
    // MARK: - Public func
    
    func getCoordinate() -> (lat: Double?, long: Double?) {
        return (self.lat, self.long)
    }
    
    func getTopViewType() -> TopViewType? {
        return topViewType
    }
    
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
        
        self.service.getCurrentWeather(lat: lat, long: long) { [weak self] result in
            switch result {
            case .success(let topViewType):
                self?.topViewType = topViewType
                self?.onDidChangeValues()
                
            case .failure(let error):
                self?.onDidError(error)
            }
        }
        
        service.getHourlyForecast(lat: lat, long: long) { [weak self] result in
            
            switch result {
            case .success(let hourly):
                self?.hourlyForecast = hourly
                self?.onDidChangeValues()
                
            case .failure(let error):
                self?.onDidError(error)
            }
            
        }
        
        service.getDaylyForecast(lat: lat, long: long) { [weak self] result in
            
            switch result {
            case .success(let dayly):
                self?.daylyForecast = dayly
                self?.onDidChangeValues()
                
            case .failure(let error):
                self?.onDidError(error)
            }
        }
    }
}
