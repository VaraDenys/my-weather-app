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
    
// MARK: - Properties
    
    private let service = WeatherService()
    
    private let provider = MoyaProvider<AerisweatherForecastAPIEndpoint>()
    
    var location: String = ""
    
    var resultFilteredCities: [ResultFilteredCities] = []
    
    var onDidChangeValues: (() -> Void)!
    
// MARK: - Init
    
    init(location: String) {
        super.init()
        
        self.location = location
    }
    
// MARK: - Public func
    
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
}
