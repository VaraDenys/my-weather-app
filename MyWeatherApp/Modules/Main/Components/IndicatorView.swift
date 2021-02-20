//
//  IndicatorView.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 18.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

class IndicatorView: View {

    private let image = UIImageView()
    
    private let labelView = UILabel()
    
    override func setupConstraints() {
        super.setupConstraints()
        
        addSubview(image)
        addSubview(labelView)
        
        image.snp.makeConstraints({
            $0.left.top.bottom.equalToSuperview().inset(4)
            $0.width.equalTo(image.snp.height)
        })
        
        labelView.snp.makeConstraints({
            $0.top.right.bottom.equalToSuperview()
            $0.left.equalTo(image.snp.right).offset(8)
        })
    }

    override func setupView() {
        super.setupView()
        image.contentMode = .scaleAspectFit
        image.tintColor = Colors.lightTintColorImage
        
        labelView.font = .systemFont(ofSize: 20)
        labelView.textColor = Colors.lightFont
        labelView.textAlignment = .left
    }
    
    func configure(icon: String, labelText: String) {
        
        self.image.image = UIImage(named: icon)?
            .resized(to: CGSize(width: 25, height: 25))
            .withRenderingMode(.alwaysTemplate)
        
        self.labelView.text = labelText
    }
}
