//
//  Screens.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 31.01.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct Screens {
    static func main(latitude: Double?, longitude: Double?) -> MainViewController {
        let viewModel = MainViewModel(latitude: latitude, longitude: longitude)
        return MainViewController(viewModel: viewModel)
    }
    
    static func search(location: String) -> SearchTableViewController {
        let viewModel = SearchTableViewModel(location: location)
        return SearchTableViewController(viewModel: viewModel)
    }
    
    static func map() -> MapViewController {
        let viewModel = MapViewModel()
        return MapViewController(viewModel: viewModel)
    }
}
