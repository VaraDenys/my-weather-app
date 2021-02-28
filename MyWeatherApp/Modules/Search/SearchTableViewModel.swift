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
    
    private var location: String = ""
    
    private var resultFilteredCities: [ResultFilteredCities] = []
    
    var onDidChangeValues: (() -> Void)!
    
    var onDidError: ((MyErrorType) -> Void)!
    
// MARK: - Init
    
    init(location: String) {
        super.init()
        
        self.location = location
    }
    
// MARK: - Public func
    
    func getLocation() -> String {
        return self.location
    }
    
    func getCount() -> Int {
        return resultFilteredCities.count
    }
    
    func getItem(for indexPath: IndexPath) -> ResultFilteredCities {
        return resultFilteredCities[indexPath.row]
    }
    
    func resumeFetch(searchText: String) {
        
        service.getSearchCity(searchText: searchText) { [weak self] (result) in
            
            switch result {
                
            case .success(let resultCities):
                
                self?.resultFilteredCities = resultCities
                
                self?.onDidChangeValues()
                
            case .failure(let error):
                
                self?.resultFilteredCities.removeAll()
                
                self?.onDidError(error)
            }
        }
    }
}
