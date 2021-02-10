//
//  StackView.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 04.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

class StackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupView() {}
    public func setupConstraints() {}
}
