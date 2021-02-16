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
    
    private let provider = MoyaProvider<AerisweatherForecastService>()
    
    private var location: String = ""
    
    init(location: String) {
        super.init()
        
        self.location = location
    }
    
    func resumeFetch(searchText: String, tableView: UITableView) {
        
        provider.request(.getSearchCity(searchText: searchText)) { (result) in
            
            switch result {
                
            case .success(let response):
                
                let res = try? response.map(FilteredListOfCities.self)
                
                guard let cities = res?.response else {
                    ResultFilteredCities.data.removeAll()
                    tableView.reloadData()
                    return
                }
                
                ResultFilteredCities.data.removeAll()
                
                for index in 0...cities.count - 1 {
                    
                    ResultFilteredCities.data.append(ResultFilteredCities(nameCities: cities[index].city.name, nameCountry: cities[index].city.countryFull ?? ""))
                }
                
                tableView.reloadData()

            case .failure(_):
                fatalError()
            }
        }
    }
    
    
}
