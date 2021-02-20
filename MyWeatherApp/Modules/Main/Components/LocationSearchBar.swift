//
//  LocationSearchBar.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 18.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

class LocationSearchBar: UIControl {

    private let textField = UITextField()
    
    override var intrinsicContentSize: CGSize {
      return UIView.layoutFittingExpandedSize
    }
    
    var location: String {
        get { return self.textField.text! }
        set { self.textField.text = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTitle(location: String) {
        self.textField.text = location
    }
    
    private func setupConstraints() {
        
        addSubview(textField)
        
        textField.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
    }
    
    private func setupView() {
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: 24)
        textField.textColor = Colors.lightFont
        
        textField.isUserInteractionEnabled = false
    }

}
