//
//  DayForecastCell.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 04.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

class DayForecastCell: TableViewCell {
    
//    MARK: - Properties

    private let dayOfTheWeek = UILabel()
    
    private let temperature = UILabel()
    
    private let imageDayForecast = UIImageView()
    
//    MARK: - Override
    
    override func setupConstraints() {
        super.setupConstraints()
        addSubview(dayOfTheWeek)
        addSubview(temperature)
        addSubview(imageDayForecast)
        
        dayOfTheWeek.snp.makeConstraints({
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo(100)
        })
        
        imageDayForecast.snp.makeConstraints({
            $0.top.right.bottom.equalToSuperview()
            $0.width.equalTo(100)
        })
        
        temperature.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(dayOfTheWeek.snp.right)
            $0.right.equalTo(imageDayForecast.snp.left)
        })
    }
    
    override func setupView() {
        super.setupView()
        
        selectionStyle = .none
        separatorInset = .init(top: 5, left: 0, bottom: 0, right: 0)
        
        layer.shadowColor = Colors.collectionBackground.cgColor
        layer.shadowOffset = .init(width: 0, height: 5)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.25
        clipsToBounds = true
        
        imageDayForecast.contentMode = .scaleAspectFit
        imageDayForecast.tintColor = Colors.darkTintColorImage
        imageDayForecast.transform = .init(scaleX: 0.5, y: 0.5)
        
        temperature.textAlignment = .center
        temperature.textColor = Colors.darkFont
        temperature.font = .systemFont(ofSize: 24)
        
        dayOfTheWeek.font = .systemFont(ofSize: 20)
        dayOfTheWeek.textColor = Colors.darkFont
        dayOfTheWeek.textAlignment = .center
    }
    
//    MARK: - Public func
    
    func configure(_ item: DayForecastType) {
        dayOfTheWeek.text = item.dayOfTheWeek
        temperature.text = item.temperature
        imageDayForecast.image = UIImage(named: item.image)
    }

    func setSelectColorAndShadow(isSelected: Bool) {
        switch isSelected {
        case true:
            dayOfTheWeek.textColor = Colors.selectionCellTableView
            temperature.textColor = Colors.selectionCellTableView
            imageDayForecast.tintColor = Colors.selectionCellTableView
            clipsToBounds = false
        case false:
            dayOfTheWeek.textColor = Colors.darkFont
            temperature.textColor = Colors.darkFont
            imageDayForecast.tintColor = Colors.darkTintColorImage
            clipsToBounds = true
        }
    }
}
