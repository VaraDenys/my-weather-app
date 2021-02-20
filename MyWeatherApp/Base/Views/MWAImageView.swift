//
//  MWAImageView.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 18.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

public class WAImageView: UIView {

    // MARK: - Properties
    
    private let imageView = UIImageView()
    
    public var image: UIImage? {
        set {
            imageView.image = newValue
        }
        get {
            imageView.image
        }
    }
    
    public override var contentMode: UIView.ContentMode {
        didSet {
            imageView.contentMode = self.contentMode
        }
    }
    
    // MARK: - Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfe Cycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        imageView.frame = self.bounds
    }
    
    // MARK: - Functions
    
    private func setupView() {
        addSubview(imageView)
        imageView.frame = self.bounds
    }
}
