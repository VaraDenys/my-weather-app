//
//  TopView.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 31.01.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit
import SnapKit

class TopView: View {

//    MARK: - Properties
    
    private let dateView = UILabel()
    private let forecastImageView = UIImageView()
    private let indicatorsStackView = StackView()
    private let temperatureView = IndicatorView()
    private let humidityView = IndicatorView()
    private let windView = IndicatorView()
    private let emptyViewFirst = View()
    private let emptyViewSecond = View()
    
//    MARK: - Override

    override func setupConstraints() {
        super.setupConstraints()
        
        addSubview(dateView)
        addSubview(forecastImageView)
        addSubview(indicatorsStackView)
        
        indicatorsStackView.addArrangedSubview(temperatureView)
        indicatorsStackView.addArrangedSubview(humidityView)
        indicatorsStackView.addArrangedSubview(windView)
        
        dateView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(24)
        })
        
        forecastImageView.snp.makeConstraints({
            $0.top.equalTo(dateView.snp.bottom)
            $0.left.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        })
        
        indicatorsStackView.snp.makeConstraints({
            $0.left.equalTo(forecastImageView.snp.right).offset(8)
            $0.top.equalTo(dateView.snp.bottom).offset(64)
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.width.equalTo(300)
        })
    }
    
    override func setupView() {
        super.setupView()
        
        let date = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let dayStr = DateString.weekDay(dayNumber: weekday)
        let monthStr = DateString.month(monthNumber: month)
        let dateStr = "\(dayStr), \(day) \(monthStr)"
        
        dateView.text = dateStr
        dateView.textColor = Colors.lightFont
        dateView.font = .systemFont(ofSize: 14)

        forecastImageView.tintColor = Colors.lightTintColorImage
        forecastImageView.contentMode = .scaleAspectFit
        forecastImageView.transform = .init(scaleX: 0.7, y: 0.7)
        
        indicatorsStackView.axis = .vertical
    }
    
        // MARK: - User Interaction
    
    public func configure(date: String, image: String, temp: String, humid: String, wind: String) {
        
        self.forecastImageView.image = UIImage(named: image)
        self.temperatureView.configure(icon: "thermometer", labelText: "\(temp)°")
        self.humidityView.configure(icon: "drop", labelText: "\(humid)%")
        self.windView.configure(icon: "wind", labelText: "\(wind) m/sec")
    }
}


