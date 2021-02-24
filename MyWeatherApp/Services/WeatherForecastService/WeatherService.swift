//
//  CurrentWeatherService.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 22.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation
import Alamofire
import Moya


class WeatherService {
    
    private let provider = MoyaProvider<AerisweatherForecastAPIEndpoint>()
    
    public func getCurrentWeather(lat: Double, long: Double, completion: @escaping (Result<TopViewType,ErrorTypeServise>) -> Void) {
        
        provider.request(.getCurrentWeather(latitude: lat, longitude: long)) { (result) in
            
            switch result {
                
            case .success(let response):
                
                do {
                    
                    let res = try response.map(CurrentWeatherResponse.self)
                    
                    guard let placeName = res.valueResponse.first?.placeLocation.nameCity,
                        
                        let date = res.valueResponse.first?.periods.first?.dateTimeISO,
                        
                        let temp = res.valueResponse.first?.periods.first?.currentTemp,
                        
                        let humidity = res.valueResponse.first?.periods.first?.humidity,
                        
                        let wind = res.valueResponse.first?.periods.first?.windSpeedKPH,
                        
                        let icon = res.valueResponse.first?.periods.first?.icon else {
                            
                            completion(.failure(.invalidValues))
                            return
                    }
                    
                    let currentWind = Int(wind * 0.27)
                    
                    let topViewType = TopViewType(
                        location: placeName,
                        date: date,
                        image: icon,
                        temperature: String(Int(temp)),
                        humidity: String(humidity),
                        wind: String(currentWind)
                    )
                    
                    completion(.success(topViewType))
                } catch {
                    completion(.failure(.invalidRequest))
                }
                
            case .failure(let error):
                debugPrint("Current request error: \(error)")
            }
        }
    }
    
    public func getHourlyForecast(lat: Double, long: Double, completion: @escaping ([HourlyType]) -> Void) {
        
        provider.request(.getForecastHourly(latitude: lat, longitude: long)) { (result) in
            
            switch result {
                
            case .success(let response):
                
                //                do {
                
                let res = try? response.map(HourlyForecastResponse.self)
                
                guard let periods = res?.response?.first?.periods else { return }
                
                var hourlyArray: [HourlyType] = []
                
                for index in 0...periods.count - 1 {
                    
                    let time = periods[index].validTime
                    
                    guard let range = time.range(of: "T") else { return }
                    
                    var correctTime = time[range.upperBound...].trimmingCharacters(in: .whitespaces)
                    
                    correctTime.removeLast(9)
                    
                    let temperature = periods[index].maxTempC
                    
                    let icon = periods[index].icon
                    
                    hourlyArray.append(HourlyType(hour: correctTime, image: icon, temperature: temperature))
                }
                //
                completion(hourlyArray)
                
            case .failure(let error):
                debugPrint("Hourly request error: \(error)")
            }
        }
    }
    
    public func getDaylyForecast(lat: Double, long: Double, completion: @escaping ([DayForecastType]) -> Void) {
        
        provider.request(.getForecastDayly(latitude: lat, longitude: long)) { (result) in
            switch result {
            case .success(let response):
                
                let res = try? response.map(DaylyForecastResponse.self)
                
                guard let periods = res?.response?.first?.periods else { return }
                
                var daylyArray: [DayForecastType] = []
                
                for index in 0...periods.count - 1 {
                    
                    let time = periods[index].timestamp
                    
                    let maxTemp = periods[index].maxTempC
                    
                    let minTemp = periods[index].minTempC
                    
                    let icon = periods[index].icon
                    
                    let weekDay = Calendar.current.component(.weekday, from: Date(timeIntervalSince1970: Double(time)))
                    
                    let weekdayString = DateString.weekDay(dayNumber: weekDay)
                    
                    daylyArray.append(DayForecastType(
                        dayOfTheWeek: weekdayString,
                        temperature: "\(maxTemp)°/\(minTemp)°",
                        image: icon)
                    )
                }
                
                completion(daylyArray)
                
            case .failure(let error):
                debugPrint("Dayly request error: \(error)")
            }
        }
    }
    
    public func getSearchCity(searchText: String, completion: @escaping ([ResultFilteredCities]) -> Void) {
        
        provider.request(.getSearchCity(location: searchText)) { (result) in
            
            switch result {
            case .success(let response):
                
                let res = try? response.map(FilteredListOfCities.self)
                
                guard let cities = res?.response else { return }
                
                var citiesArray: [ResultFilteredCities] = []
                
                for index in 0...cities.count - 1 {
                    
                    let nameCity = cities[index].city.name
                    let countryName = cities[index].city.countryFull
                    let lat = cities[index].coordinate.lat
                    let long = cities[index].coordinate.long
                    
                    citiesArray.append(ResultFilteredCities(nameCities: nameCity, nameCountry: countryName, lat: lat, long: long))
                }
                
                completion(citiesArray)
                
            case .failure(let error):
                debugPrint("Cities request error: \(error)")
            }
            
        }
        
    }
    
    public func getPlaceByCoordinate(lat: Double, long: Double, completion: @escaping ([Double]) -> Void) {
        
        provider.request(.getPlaceByCoordinate(latitude: lat, longitude: long)) { (result) in
            switch result {
            case .success(let response):
                
                let res = try? response.map(PlacesByCoordinate.self)
                
                guard let lat = res?.response?.first?.coordinateCorrect.lat,
                    let long = res?.response?.first?.coordinateCorrect.long else { return }
                
                let resutArray = [lat, long]
                
                completion(resutArray)
                
            case .failure(let error):
                
                debugPrint("Place coordinate request error: \(error)")
                
            }
        }
    }
}
