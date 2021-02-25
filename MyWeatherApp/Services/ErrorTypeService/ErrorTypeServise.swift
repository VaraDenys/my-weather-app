//
//  ErrorTypeServise.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 24.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation


enum ErrorTypeServise: String, Error {
    
    case internetDisconnect = "Network disabled"
    case serviceLocationDisabled = "Service location disabled"
    
    case invalidRequest = "Invalid request"
    case invalidValues = "Invalid value"
    
}
