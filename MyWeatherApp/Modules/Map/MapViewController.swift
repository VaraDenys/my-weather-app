//
//  MapViewController.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 17.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation

class MapViewController: ViewController<MapViewModel> {
    
//    MARK: - Private properties
    
    private let cancelButton = UIBarButtonItem()
    
    private let targetButton = UIBarButtonItem()
    
    private let manager = CLLocationManager()
    
    private let mapView = MKMapView()
    
    private let gestureChoiceLocation = UITapGestureRecognizer()
    
//    MARK: - Override Func
    
    override func setupConstraints() {
        
        view.addSubview(mapView)
        mapView.addGestureRecognizer(gestureChoiceLocation)
        
        mapView.snp.makeConstraints({
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(self.topLayoutGuide.snp.bottom)
        })
    }
    
    override func setupView() {
        
        manager.delegate = self
        
        view.backgroundColor = Colors.appBackground
        
        mapView.delegate = self
        mapView.setUserTrackingMode(.follow, animated: true)
        
        gestureChoiceLocation.delaysTouchesBegan = true
        gestureChoiceLocation.delegate = self
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : Colors.lightFont ]
        navigationItem.leftBarButtonItem = cancelButton
        cancelButton.title = "Cancel"
        cancelButton.setTitleTextAttributes(
            [.foregroundColor : Colors.lightFont, .font : UIFont.systemFont(ofSize: 20)],
            for: .normal)
        
        navigationItem.rightBarButtonItem = targetButton
        targetButton.image = Images
            .targetIcon
            .get()
            .resized(to: CGSize(width: 25, height: 25))
            .withRenderingMode(.alwaysTemplate)
        
        targetButton.tintColor = Colors.lightTintColorImage
    }
    
    override func setupLocation() {
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestWhenInUseAuthorization()
        
        manager.startUpdatingLocation()
    }
    
    override func binding() {
        super.binding()
        
        cancelButton.target = self
        cancelButton.action = #selector(actionCancel(sender:))
        
        targetButton.target = self
        targetButton.action = #selector(actionTargetButton(sender:))
        
        gestureChoiceLocation.addTarget(self, action: #selector(handleLongPress(gestureRecognizer:)))
    }
    
//    MARK: - User interaction
    
    @objc func actionCancel(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func actionTargetButton(sender: UIBarButtonItem) {
        
        manager.startUpdatingLocation()
        
        guard let coordinate = manager.location?.coordinate else { return }
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    @objc func handleLongPress(gestureRecognizer: UITapGestureRecognizer) {
        
        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            return
        }
            
        else if gestureRecognizer.state != UIGestureRecognizer.State.began {
            
            let touchPoint = gestureRecognizer.location(in: self.mapView)
            
            let touchMapCoordinate =  self.mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            let region = MKCoordinateRegion(center: touchMapCoordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            
            mapView.setRegion(region, animated: true)
            
            let alert = UIAlertController(title: "Want to see the weather of the selected region?", message: nil, preferredStyle: .alert)
            
            let alertActionPozitive = UIAlertAction(title: "Yes", style: .default) { [weak self] (action) in
                
                guard let self = self else { return }
                
                let lat = self.mapView.region.center.latitude
                let lon = self.mapView.region.center.longitude
                
                self.viewModel.requestLocationByCoordinate(
                    latitude: lat,
                    longitude: lon
                )
                
                self.viewModel.onDidChangeLocation = { [weak self] arrayCoor in
                    
                    guard let self = self else { return }
                    
                    self.navigationController?.pushViewController(
                        Screens.main(latitude: arrayCoor[0], longitude: arrayCoor[1]),
                        animated: false)
                }
                
            }
            
            let alertActionNegative = UIAlertAction(title: "No", style: .cancel) { [weak self ](alertAction) in
                
                guard let self = self else { return }
                
                debugPrint("3")
                
                self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(alertActionPozitive)
            alert.addAction(alertActionNegative)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
//    MARK: - Public func
    
    func render(_ location: CLLocation) {
        
        let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude,
                                                    location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        mapView.setRegion(region, animated: true)
    }
}

//    MARK: - Extension

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        manager.stopUpdatingLocation()
        
        guard let location = manager.location else { return }
        
        render(location)
    }
}

extension MapViewController: MKMapViewDelegate {
    
}

extension MapViewController: UIGestureRecognizerDelegate {
    
}
