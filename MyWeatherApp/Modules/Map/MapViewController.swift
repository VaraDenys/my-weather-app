//
//  MapViewController.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 04.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class MapViewController: ViewController<MapRouter, MapViewModel> {
    
//    MARK: - Private properties
    
    private let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//    MARK: - Override
    
    override func setupConstraints() {
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }

}
