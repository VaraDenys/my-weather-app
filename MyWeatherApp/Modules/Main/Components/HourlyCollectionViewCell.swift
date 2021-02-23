//
//  HourlyCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 04.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: CollectionViewCell {
    
//    MARK: - Properties
 
    private let hourTitle = UILabel()
    
    private let imageForecast = UIImageView()
    
    private let temperatureLable = UILabel()
    
//    MARK: - Override
    
    override func setupConstraints() {
        super.setupConstraints()
        
        addSubview(hourTitle)
        addSubview(imageForecast)
        addSubview(temperatureLable)
        
        hourTitle.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(65)
        })
        
        imageForecast.snp.makeConstraints({
            $0.top.equalTo(hourTitle.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(35)
        })
        
        temperatureLable.snp.makeConstraints({
            $0.top.equalTo(imageForecast.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(35)
        })
    }
    
    override func setupView() {
        super.setupView()
        
        hourTitle.textColor = Colors.lightFont
        hourTitle.textAlignment = .center
        
        imageForecast.contentMode = .scaleAspectFit
        imageForecast.tintColor = Colors.lightTintColorImage
        
        temperatureLable.textColor = Colors.lightFont
        temperatureLable.textAlignment = .center
    }
    
//    MARK: - Public func
    
    func configure(_ item: HourlyType) {
        hourTitle.text = item.hour
        imageForecast.image = UIImage(named: item.image)
        temperatureLable.text = "\(item.temperature)°"
    }
}
