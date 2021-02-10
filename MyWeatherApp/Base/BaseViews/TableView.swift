//
//  TableView.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 02.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

class TableView: UITableView {
    
//    MARK: - Override
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: -
    
    public func setupConstraints() {}
    
    public func setupView() {}
}
