//
//  LocationSearchBar.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 18.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

class LocationSearchBar: UIControl {
    
// MARK: - Properties

    private let locationLabel = UILabel()
    
    var location: String {
        get { return self.locationLabel.text ?? "" }
        set { self.locationLabel.text = newValue.capitalized }
    }
    
// MARK: - Override properties
    
    override var intrinsicContentSize: CGSize {
      return UIView.layoutFittingExpandedSize
    }
    
// MARK: - Override init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        
        addSubview(locationLabel)
        
        locationLabel.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
    }
    
    private func setupView() {
        locationLabel.textAlignment = .left
        locationLabel.font = .systemFont(ofSize: 24)
        locationLabel.textColor = Colors.lightFont
        
        locationLabel.isUserInteractionEnabled = false
    }
    
    public func setTitle(location: String) {
        self.location = location
    }
}
