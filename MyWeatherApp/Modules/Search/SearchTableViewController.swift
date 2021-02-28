//
//  ResultTableViewController.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 13.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit
import SnapKit
import Reachability

class SearchTableViewController: ViewController<SearchTableViewModel> {
    
// MARK: - Private properties
    
    private let backButton = UIBarButtonItem()
    
    private let searchNavigationTextField = LocationSearchTextField()
    
    private let loupeButton = UIBarButtonItem()
    
    private let tableView = UITableView()
    
    private let notFoundLabel = UILabel()
    
// MARK: - Override init
    
    override init(viewModel: SearchTableViewModel) {
        super.init(viewModel: viewModel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        try? addReachabilityObserver()
    }
    
// MARK: - Override func
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(tableView)
        view.addSubview(notFoundLabel)
        
        tableView.snp.makeConstraints({ [weak self] in
            
            guard let self = self else { return }
            
            $0.top.equalTo(self.topLayoutGuide.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        })
        
        notFoundLabel.snp.makeConstraints({ [weak self] in
            
            guard let self = self else { return }
            
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(self.topLayoutGuide.snp.bottom).offset(30)
        })
    }
    
    override func setupView() {
        
        view.backgroundColor = Colors.appBackground
        
        notFoundLabel.text = "Not found"
        notFoundLabel.textAlignment = .center
        notFoundLabel.isHidden = true
        notFoundLabel.textColor = .gray
    }
    
    override func setupTableView() {
        super.setupTableView()
        tableView.separatorStyle = .none
        
        tableView.register(
            ResultTableViewCell.self,
            forCellReuseIdentifier: String(describing: ResultTableViewCell.self)
        )
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        self.navigationItem.leftBarButtonItem = backButton
        
        self.navigationItem.titleView = searchNavigationTextField
        
        self.navigationItem.rightBarButtonItem = loupeButton
        
        backButton.image = Images
            .backButton
            .get()
            .resized(
                to: CGSize(width: 25,
                           height: 25))
            .withRenderingMode(.alwaysTemplate)
        backButton.tintColor = Colors.lightTintColorImage
        
        searchNavigationTextField.delegate = self
        searchNavigationTextField.setTitle(location: self.viewModel.getLocation())
        
        loupeButton.image = Images
            .searchBarLoupe
            .get()
            .resized(to: CGSize(
                width: 25,
                height: 25))
            .withRenderingMode(.alwaysTemplate)
        loupeButton.tintColor = Colors.lightTintColorImage
    }
    
    override func setupLocation() {
        super.setupLocation()
        
        let searchText = self.viewModel.getLocation()
        
        self.viewModel.resumeFetch(searchText: searchText)
    }
    
    override func binding() {
        super.binding()
        
        self.viewModel.onDidChangeValues = { [weak self] in
            
            guard let self = self else { return }
            
            self.notFoundLabel.isHidden = true
            
            self.tableView.reloadData()
        }
        
        self.viewModel.onDidError = { [weak self] error in
            switch error {
            case .invalidRequest:
                
                self?.notFoundLabel.isHidden = false
                
                self?.tableView.reloadData()
                
            default:
                break
            }
        }
        
        backButton.target = self
        backButton.action = #selector(backAction(sender:))
        
        loupeButton.target = self
        loupeButton.action = #selector(loupeAction(sender:))
    }
    
// MARK: - User Interraction
    
    @objc func backAction(sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func loupeAction(sender: UIBarButtonItem) {
        
        try? addReachabilityObserver()
        
        let requestLocation = searchNavigationTextField.getLocation()
        
        self.viewModel.resumeFetch(searchText: requestLocation)
    }
}

// MARK: - Extension

extension SearchTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        try? addReachabilityObserver()
        
        self.viewModel.resumeFetch(searchText: textField.text ?? "")
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        self.viewModel.resumeFetch(searchText: textField.text ?? "")
    }
}

extension SearchTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = String(describing: ResultTableViewCell.self)
        
        guard let cell = self.tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath) as? ResultTableViewCell
            else {
                fatalError("Fatal error \(identifier)")
        }
        
        let item = self.viewModel.getItem(for: indexPath)
        
        cell.configure(
            nameCity: item.nameCities,
            nameCountry: item.nameCountry,
            lat: item.lat,
            long: item.long
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? ResultTableViewCell else { return }
        
        var location = cell.getCityName()
        
        let arrayCoordinate = cell.getCoordinate()
        
        _ = location.popLast()
        
        self.navigationController?.pushViewController(
            Screens.main(latitude: arrayCoordinate.lat, longitude: arrayCoordinate.long),
            animated: true)
    }
}

extension SearchTableViewController: ReachabilityObserverDelegate {
    
    func reachabilityChanged(_ isReachability: Bool) {
        
        if !isReachability {
            
            self.showAlert(
                title: MyErrorType.internetDisconnect.rawValue,
                message: "Open your Settings app Settings and then \"Wireless & networks\" or \"Connections\"",
                cancelTitle: "Ok",
                actionTitle: "Settings") { (alert) in
                    
                    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                    
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
