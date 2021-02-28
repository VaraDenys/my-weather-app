//
//  Alerts.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 27.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//



import Foundation
import UIKit

struct AlertController {
    
    static func getAlert(
        title: String,
        message: String?,
        cancelTitle: String,
        actionTitle: String?,
        completion: ((UIAlertAction) -> Void)?
    ) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        if let actionTitle = actionTitle {
            
            let action = UIAlertAction(title: actionTitle, style: .default, handler: completion)
            
            alert.addAction(action)
        }
        
        return alert
    }
    
}
