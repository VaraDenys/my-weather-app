//
//  DayForecastCell.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 04.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

class DayForecastCell: TableViewCell {
    
// MARK: - Properties
    
    private let backgroundWhiteView = UIView()

    private let dayOfTheWeek = UILabel()
    
    private let temperature = UILabel()
    
    private let imageDayForecast = UIImageView()
    
// MARK: - Override
    
    override func setupConstraints() {
        super.setupConstraints()
        addSubview(backgroundWhiteView)
        addSubview(dayOfTheWeek)
        addSubview(temperature)
        addSubview(imageDayForecast)
        
        backgroundWhiteView.snp.makeConstraints({
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(3)
            $0.bottom.equalToSuperview().inset(6)
        })
        
        dayOfTheWeek.snp.makeConstraints({
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo(100)
        })
        
        imageDayForecast.snp.makeConstraints({
            $0.right.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalToSuperview()
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
        
        backgroundWhiteView.backgroundColor = .white
        
        imageDayForecast.contentMode = .scaleAspectFit
        imageDayForecast.tintColor = Colors.darkTintColorImage
        imageDayForecast.transform = .init(scaleX: 0.5, y: 0.5)
        
        temperature.textAlignment = .center
        temperature.font = .systemFont(ofSize: 24)
        
        dayOfTheWeek.font = .systemFont(ofSize: 20)
        dayOfTheWeek.textAlignment = .center
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        switch selected {
        case true:
            
            dayOfTheWeek.textColor = Colors.selectionCellTableView
            temperature.textColor = Colors.selectionCellTableView
            
            contentView.layer.shadowPath = CGPath(rect: self.bounds, transform: nil)
            contentView.layer.shadowOpacity = 0.2
            contentView.layer.shadowRadius = 3
            contentView.layer.shadowColor = Colors.collectionBackground.cgColor
            
        case false:
            
            dayOfTheWeek.textColor = Colors.darkFont
            temperature.textColor = Colors.darkFont
            
            contentView.layer.shadowPath = .none
            contentView.layer.shadowOpacity = 0
            contentView.layer.shadowRadius = 0
        }
    }
    
// MARK: - Public func
    
    func configure(_ item: DayForecastType) {
        dayOfTheWeek.text = item.dayOfTheWeek
        temperature.text = item.temperature
        imageDayForecast.image = UIImage(named: item.image)
    }
}
