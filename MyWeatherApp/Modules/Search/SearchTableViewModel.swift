//
//  ResultTableViewModel.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 13.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit
import Moya

class SearchTableViewModel: ViewModel {
    
    private let provider = MoyaProvider<AerisweatherForecastAPIEndpoint>()
    
    private let service = WeatherService()
    
    var location: String = ""
    
    var resultFilteredCities: [ResultFilteredCities] = []
    
    var onDidChangeValues: (() -> Void)!
    
    init(location: String) {
        super.init()
        
        self.location = location
    }
    
    func getCount() -> Int {
        return resultFilteredCities.count
    }
    
    func getItem(for indexPath: IndexPath) -> ResultFilteredCities {
        return resultFilteredCities[indexPath.row]
    }
    
    func resumeFetch(searchText: String) {
        
        service.getSearchCity(searchText: searchText) { (result) in
            self.resultFilteredCities = result
            self.onDidChangeValues()
        }
    }
    
//    func resumeFetch(searchText: String, tableView: UITableView) {
//
//        provider.request(.getSearchCity(location: searchText)) { (result) in
//
//            switch result {
//
//            case .success(let response):
//
//                let res = try? response.map(FilteredListOfCities.self)
//
//                guard let cities = res?.response else {
//                    tableView.reloadData()
//                    return
//                }
//
//
//
//                for index in 0...cities.count - 1 {
//
//                    let nameCitie = cities[index].city.name
//
//                    let nameCountry = cities[index].city.countryFull
//
//                    let lat = cities[index].coordinate.lat
//                    let long = cities[index].coordinate.long
//
//                    ResultFilteredCities.data.append(ResultFilteredCities(
//                        nameCities: nameCitie,
//                        nameCountry: nameCountry,
//                        lat: lat,
//                        long: long))
//                }
//
//                tableView.reloadData()
//
//            case .failure(_):
//                fatalError()
//            }
//        }
//    }
    
    
}
