//
//  LocationSearchTextField.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 18.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

class LocationSearchTextField: UIControl {

    private var textField = TextField()
    
    var delegate: UITextFieldDelegate {
        get { return self.textField.delegate! }
        set { self.textField.delegate = newValue }
    }
    
    var location: String {
        get { return self.textField.text ?? "" }
        set { self.textField.text = newValue}
    }

    override var intrinsicContentSize: CGSize {
      return UIView.layoutFittingExpandedSize
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
            $0.width.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(8)
        })
        
    }
    
    private func setupView() {
        textField.backgroundColor = Colors.lightTintColorImage
        textField.font = .systemFont(ofSize: 20)
        textField.textColor = Colors.darkFont
        textField.textAlignment = .left
        textField.setEdgePadding(8)
        
        textField.layer.cornerRadius = 5
    }
}
