//
//  WeatherCodeImage.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 20.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation
import UIKit

enum CloudyCodeImage: String {
    case CL
    case FW
    case SC
    case BK
    case OV
}

enum WeatherImage: String {
    
    case sunny
    case cloudy
    
    func get(cloudyCode: String, weatherCode: String) -> UIImage {
        
        var imageName: String = ""
        
        if cloudyCode == "CL" || cloudyCode == "FW" {
            imageName = "Sunny"
        } else if cloudyCode == "SC" || cloudyCode == "BK" {
            imageName = weatherCode
        } else if cloudyCode == "OV" {
                imageName = weatherCode + "w"
        }
        
        guard let result = UIImage(named: imageName) else {
            fatalError("Тo image with name found \(imageName)")
        }
        
        return result
    }
}

enum WeatherCodeImage: String {
    case A
    case BD
    case BN
    case BR
    case BS
    case BY
    case F
    case FR
    case H
    case IC
    case IF
    case IP
    case K
    case L
    case R
    case RW
    case RS
    case SI
    case WM
    case S
    case SW
    case T
    case UP
    case VA
    case WP
    case ZF
    case ZL
    case ZR
    case ZY
}
