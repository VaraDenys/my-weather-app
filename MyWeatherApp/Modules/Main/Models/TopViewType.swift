//
//  File.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 16.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation
import UIKit


struct TopViewType {
    var date: String
    var image: String
    var temperature: String
    var humitity: String
    var wind: String
    
    func getImage(imageName: String) -> UIImage {
        guard let result = UIImage(named: imageName) else { return UIImage() }
        return result
    }
    
    static var data: TopViewType?
}
