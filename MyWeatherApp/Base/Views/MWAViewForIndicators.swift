//
//  MWAViewForIndicators.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 09.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

class MWAViewForIndicators: View {
    
//    MARK: - Properties

    private let image = UIImageView()
    
    private let indicatorValue = UILabel()
    
//    MARK: - Override
    
    override func setupConstraints() {
        super.setupConstraints()
        
        addSubview(image)
        addSubview(indicatorValue)
        
        image.snp.makeConstraints({
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo(image.snp.height)
        })
        
        indicatorValue.snp.makeConstraints({
            $0.left.equalTo(image.snp.right).offset(8)
            $0.top.right.bottom.equalToSuperview()
        })
    }
    
    override func setupView() {
        super.setupView()
        
        image.contentMode = .scaleAspectFit
        image.tintColor = .white
        
        indicatorValue.textAlignment = .left
        indicatorValue.font = .systemFont(ofSize: 20)
        indicatorValue.textColor = .white
    }
    
//    MARK: - Public func
    
    func configure(item: IndicatorsType) {
        image.image = item.icon.withRenderingMode(.alwaysTemplate)
        indicatorValue.text = item.indicatorValueTitle
    }
}
