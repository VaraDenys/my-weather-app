//
//  Screens.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 31.01.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct Screens {
    static func main() -> MainViewController {
        let viewModel = MainViewModel()
        return MainViewController(viewModel: viewModel)
    }
    
    static func map() -> MapViewController {
        let viewModel = MapViewModel()
        return MapViewController(viewModel: viewModel)
    }
}
