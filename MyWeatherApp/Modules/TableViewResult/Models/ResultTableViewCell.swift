//
//  ResultTableViewCell.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 13.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit
import SnapKit

class ResultTableViewCell: TableViewCell {
    
    private let stackView = UIStackView()

    private let citiesLabel = UILabel()
    
    private let countryLabel = UILabel()
    
    private let viewEmpty = UIView()
    
    override func setupConstraints() {
        super.setupConstraints()
        
        addSubview(stackView)
        stackView.addArrangedSubview(citiesLabel)
        stackView.addArrangedSubview(countryLabel)
        stackView.addArrangedSubview(viewEmpty)
        
        stackView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    override func setupView() {
        super.setupView()
        
        stackView.axis = .horizontal
        stackView.spacing = 4
    }
    
    func configure(nameCity: String, nameCountry: String) {
        citiesLabel.text = "\(nameCity),"
        countryLabel.text = "\(nameCountry)"
    }
    
    func getCityName() -> String {
        return citiesLabel.text ?? ""
    }

}
