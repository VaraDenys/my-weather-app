//
//  IndicatorsStackView.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 09.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

//import UIKit
//
//class IndicatorsStackView: StackView {
//    
////    MARK: - Properties
//
//    private let temperatureView = MWAViewForIndicators()
//    
//    private let humidityView = MWAViewForIndicators()
//    
//    private let windView = MWAViewForIndicators()
//    
//    public func configure(valueTemp: String, valueHumidity: Int, valueWind: Int) {
//        temperatureView.configure(item: .temperature, value: valueTemp)
//        humidityView.configure(item: .humidity, value: String(valueHumidity) + "%")
//        windView.configure(item: .wind, value: String(valueWind) + "m/sec")
//    }
//
////    MARK: - Override
//    
//    override func setupConstraints() {
//        addArrangedSubview(temperatureView)
//        addArrangedSubview(humidityView)
//        addArrangedSubview(windView)
//    }
//    
//    override func setupView() {
//        backgroundColor = Colors.appBackground
//        axis = .vertical
//        spacing = 12
//    }
//}
