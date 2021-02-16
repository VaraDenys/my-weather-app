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
    
    private let locationStackView = UIStackView()
    
    private let locationButton = UIButton()
    
    public let cityNameTextField = UITextField()
    
    private let targetButton = UIButton()
    
    private let dateView = UILabel()
    
    private let forecastImageView = UIImageView()
    
    private let indicatorsStackView = IndicatorsStackView()
    
    
//    MARK: - Override

    override func setupConstraints() {
        super.setupConstraints()
        addSubview(locationStackView)
        
        locationStackView.addArrangedSubview(locationButton)
        locationStackView.addArrangedSubview(cityNameTextField)
        locationStackView.addArrangedSubview(targetButton)
        
        addSubview(dateView)
        addSubview(forecastImageView)
        addSubview(indicatorsStackView)
        
        locationStackView.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(24)
        })
        
        locationButton.snp.makeConstraints({
            $0.width.equalTo(self.locationButton.snp.height)
        })

        targetButton.snp.makeConstraints({
            $0.width.equalTo(self.targetButton.snp.height)
        })
        
        dateView.snp.makeConstraints({
            $0.top.equalTo(locationStackView.snp.bottom).offset(16)
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
            $0.top.equalTo(dateView.snp.bottom).offset(48)
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.width.equalTo(300)
        })
    }
    
    override func setupView() {
        super.setupView()
        
        locationStackView.axis = .horizontal
        locationStackView.spacing = 8
        
        locationButton.setImage(
            Images.locationIcon.get().withRenderingMode(.alwaysTemplate),
            for: .normal)
        locationButton.contentMode = .scaleAspectFit
        locationButton.tintColor = Colors.lightTintColorImage
        
        cityNameTextField.text = "Zaporizhzhia"
        cityNameTextField.font = .systemFont(ofSize: 24)
        cityNameTextField.textColor = Colors.lightFont
        cityNameTextField.textAlignment = .left
        
        targetButton.setImage(
            Images.targetIcon.get().withRenderingMode(.alwaysTemplate),
            for: .normal)
        targetButton.tintColor = Colors.lightTintColorImage
        
        dateView.text = "ПТ, 20 июля"
        dateView.textColor = Colors.lightFont
        dateView.font = .systemFont(ofSize: 14)
        
        forecastImageView.image = Images.cloudyDay.get().withRenderingMode(.alwaysTemplate)
        forecastImageView.tintColor = Colors.lightTintColorImage
        forecastImageView.contentMode = .scaleAspectFit
        forecastImageView.transform = .init(scaleX: 0.7, y: 0.7)
    }
    
        // MARK: - User Interaction
    
    public func configure(location: String, date: String) {
        cityNameTextField.text = location
        dateView.text = date
    }
}

