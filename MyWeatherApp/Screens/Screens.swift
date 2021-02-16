//
//  Screens.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 31.01.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation

struct Screens {
    static func main(location: String) -> MainViewController {
        let viewModel = MainViewModel(location: location)
        return MainViewController(viewModel: viewModel)
    }
    
    static func search(location: String) -> SearchTableViewController {
        let viewModel = SearchTableViewModel(location: location)
        return SearchTableViewController(viewModel: viewModel)
    }
}
