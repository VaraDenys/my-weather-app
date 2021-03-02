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
    
// MARK: - Properties
    
    private var lat: Double = 0
    private var long: Double = 0
    private let stackView = UIStackView()
    private let citiesLabel = UILabel()
    private let countryLabel = UILabel()
    private let viewEmpty = UIView()
    
// MARK: - Override func
    
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
    
// MARK: - Public func
    
    func configure(nameCity: String, nameCountry: String, lat: Double, long: Double) {
        self.citiesLabel.text = "\(nameCity),"
        self.countryLabel.text = "\(nameCountry)"
        self.lat = lat
        self.long = long
    }
    
    func getCoordinate() -> (lat: Double, long: Double) {
        return (self.lat, self.long)
    }
    
    func getCityName() -> String {
        return citiesLabel.text ?? ""
    }

}
