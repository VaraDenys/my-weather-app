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
    
    private let locationIconImage = UIImageView()
    
    private let cityNameButton = UIButton()
    
    private let targetButton = UIButton()
    
    private let dateView = UILabel()
    
    private let forecastImageView = UIImageView()
    
    private let indicatorsStackView = IndicatorsStackView()

//    MARK: - Override

    override func setupConstraints() {
        super.setupConstraints()
        addSubview(locationStackView)
        
        locationStackView.addArrangedSubview(locationIconImage)
        locationStackView.addArrangedSubview(cityNameButton)
        locationStackView.addArrangedSubview(targetButton)
        
        addSubview(dateView)
        addSubview(forecastImageView)
        addSubview(indicatorsStackView)
        
        locationStackView.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(24)
        })
        
        locationIconImage.snp.makeConstraints({
            $0.width.equalTo(self.locationIconImage.snp.height)
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
        
        locationIconImage.image = Images.locationIcon.get().withRenderingMode(.alwaysTemplate)
        locationIconImage.contentMode = .scaleAspectFit
        locationIconImage.tintColor = .white
        
        cityNameButton.setTitle("Запорожье", for: .normal)
        cityNameButton.titleLabel?.font = .systemFont(ofSize: 24)
        cityNameButton.titleLabel?.textColor = .white
        cityNameButton.contentHorizontalAlignment = .left
        
        targetButton.setImage(Images.targetIcon.get().withRenderingMode(.alwaysTemplate), for: .normal)
        targetButton.tintColor = .white
        
        dateView.text = "ПТ, 20 июля"
        dateView.textColor = .white
        dateView.font = .systemFont(ofSize: 14)
        
        forecastImageView.image = Images.cloudyDay.get().withRenderingMode(.alwaysTemplate)
        forecastImageView.tintColor = .white
        forecastImageView.contentMode = .scaleAspectFit
        forecastImageView.transform = .init(scaleX: 0.7, y: 0.7)
    }
    
        // MARK: - User Interaction
}

