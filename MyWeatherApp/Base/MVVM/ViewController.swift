//
//  MainViewController.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 31.01.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit

class ViewController<VM: ViewModel>: UIViewController {
    
//    MARK: - Properties
    
    public let viewModel: VM
    
//    MARK: - Constructor
    
    public init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupView()
        setupTableView()
        setupCollectionView()
        binding()
        localize()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

//    MARK: - Child Override Functions
    
    public func setupConstraints() {}
    
    public func setupView() {}
    
    public func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    public func setupTableView() {}
    
    public func setupCollectionView() {}
    
    public func binding() {}
    
    public func localize() {}
}
