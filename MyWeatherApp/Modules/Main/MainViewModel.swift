//
//  MainViewModel.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 31.01.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

class MainViewModel: ViewModel<MainRouter> {
    
    private let indicatorsItems = IndicatorsType.allCases
    
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
}
