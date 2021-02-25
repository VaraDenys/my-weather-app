//
//  ReachabilityProtocols.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 25.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import Foundation
import Reachability

fileprivate var reachability: Reachability!

protocol ReachabilityActionDelegate {
    func reachabilityChanged(_ isReachability: Bool)
}

protocol ReachabilityObserverDelegate: class, ReachabilityActionDelegate {
    func addReachabilityObserver() throws
    func removeReachabilityObserver()
}

extension ReachabilityObserverDelegate {
    
    func addReachabilityObserver() throws {
        
        reachability = try Reachability()
        
        reachability.whenReachable = { [weak self] reachability in
            self?.reachabilityChanged(true)
        }
        
        reachability.whenUnreachable = { [weak self] reachability in
            self?.reachabilityChanged(false)
        }
        
        try reachability.startNotifier()
    }
    
    func removeReachabilityObserver() {
        reachability.stopNotifier()
        reachability = nil
    }
}
