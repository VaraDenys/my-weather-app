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
    
    //    MARK: - Properties
    
    let provider = MoyaProvider<AerisweatherForecastService>()
    
    var notFirstLoad: Bool = false
    
//    MARK: - Init
    
    init(latitude: Double?, longitude: Double?) {
        super.init()
        
        guard let lat = latitude else { return }
        guard let long = longitude else { return }
        
        self.notFirstLoad = true
        self.resumeFetch(lat: lat, long: long)
    }
    
    //    MARK: - Public
    
    var onDidChangeLocation: ((String) -> Void)?
    
    var onDidChangeValue: ((TopViewType) -> Void)?
    
    //    func indicatorsItemCount() -> Int{
    //        return indicatorsItems.count
    //    }
    
    //    func getIndicatorsItem(for indexPath: IndexPath) -> IndicatorsIconType {
    //        return indicatorsItems[indexPath.row]
    //    }
    
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
    
    
//    func requestLocationByCoordinate(latitude: Double, longitude: Double) {
//        provider.request(.getPlaceByCoordinate(latitude: latitude, longitude: longitude)) { (result) in
//
//            switch result {
//
//            case .success(let response):
//
//                let res = try? response.map(RsponseByCoordinate.self)
//
//                guard let latCorrect = res?.response?.first?.coordinateCorrect.lat else { return }
//                guard let lonGorrect = res?.response?.first?.coordinateCorrect.long else { return }
//
//                self.resumeFetch(lat: latCorrect, long: lonGorrect)
//
//            case .failure(let error):
//
//                fatalError("Fatal error - \(error)")
//            }
//        }
//    }
    
    func resumeFetch(lat: Double, long: Double) {
        
        provider.request(.getCurrentWeather(latitude: lat, longitude: long)) { (result) in
            
            switch result {
                
            case .success(let response):
                
                let res = try? response.map(CurrentWeatherResponse.self)
                
                guard let locationNameResult = res?.valueResponse.first?.placeLocation.nameCity else { return }
                guard let date = res?.valueResponse.first?.periods.first?.dateTimeISO else { return }
                guard let temperarture = res?.valueResponse.first?.periods.first?.currentTemp else { return }
                guard let humidity = res?.valueResponse.first?.periods.first?.humidity else { return }
                guard let windSpeedKPH = res?.valueResponse.first?.periods.first?.windSpeedKPH else { return }
                guard let icon = res?.valueResponse.first?.periods.first?.icon else { return }
                
                debugPrint(icon)
                
                self.onDidChangeLocation?(locationNameResult)
                
                let responseTopViewType = TopViewType(
                    date: date,
                    image: icon,
                    temperature: String(temperarture),
                    humitity: String(humidity),
                    wind: String(windSpeedKPH)
                )
                
                TopViewType.data = responseTopViewType
                
                self.onDidChangeValue?(responseTopViewType)
                
            case .failure(let error):
                fatalError("Fatal erorr: \(error)")
            }
        }
    }
    
    func requestDaylyForecast(lat: Double, long: Double, tableView: UITableView) {
        
        provider.request(.getForecastDayly(latitude: lat, longitude: long)) { (result) in
            switch result {
            case .success(let response):
                
                let res = try? response.map(DaylyForecastResponse.self)
                
                debugPrint(String(describing: res))
                
                guard let period = res?.response.first?.periods else { return }
                
                DayForecastType.data.removeAll()
                
                for index in 0...period.count - 1 {
                    
                    let time = period[index].timestamp
                    guard let maxTemp = period[index].maxTempC else { return }
                    guard let minTemp = period[index].minTempC else { return }
                    guard let icon = period[index].icon else { return }
                    
                    let calendar = Calendar.current
                    let numberWeekDay = calendar.component(.weekday, from: Date(timeIntervalSince1970: TimeInterval(time)))
                    let dayOfTheWeek = DayString(dayOfTheWeek: numberWeekDay).getStringDate()
                    
                    DayForecastType.data.append(DayForecastType(
                        dayOfTheWeek: dayOfTheWeek,
                        temperature: "\(maxTemp)°/\(minTemp)°",
                        image: UIImage(named: icon) ?? UIImage())
                    )
                }
                
//                tableView.reloadData()
            case .failure(let error):
                fatalError("The request failed. Error: \(error)")
            }
        }
    }
}
