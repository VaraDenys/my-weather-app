//
//  ResultTableViewController.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 13.02.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit
import SnapKit

class SearchTableViewController: ViewController<SearchTableViewModel> {
    
//    MARK: - Private properties
    
    private let backButton = UIBarButtonItem()
    
    private let searchNavigationTextField = LocationSearchTextField()
    
    private let loupeButton = UIBarButtonItem()
    
    private let tableView = UITableView()
    
//    MARK: - Override func

    override func setupConstraints() {

        view.addSubview(tableView)
        
        tableView.snp.makeConstraints({
            $0.top.equalTo(self.topLayoutGuide.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        })
    }
    
    override func setupView() {
        
        view.backgroundColor = Colors.appBackground
    }
    
    override func setupTableView() {
        super.setupTableView()
        tableView.separatorStyle = .none
        
        tableView.register(
            ResultTableViewCell.self,
            forCellReuseIdentifier: String(describing: ResultTableViewCell.self))
        
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
        searchNavigationTextField.location = self.viewModel.location
        
        loupeButton.image = Images
            .searchBarLoupe
            .get()
            .resized(to: CGSize(
                width: 25,
                height: 25))
            .withRenderingMode(.alwaysTemplate)
        loupeButton.tintColor = Colors.lightTintColorImage
    }
    
    override func binding() {
        
        backButton.target = self
        backButton.action = #selector(backAction(sender:))
        
        loupeButton.target = self
        loupeButton.action = #selector(loupeAction(sender:))
    }
    
//    MARK: - User Interraction
    
    @objc func backAction(sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
        
        ResultFilteredCities.data.removeAll()
    }
    
    @objc func loupeAction(sender: UIBarButtonItem) {
        
        let requestLocation = searchNavigationTextField.location
        
        self.viewModel.resumeFetch(
            searchText: requestLocation,
            tableView: self.tableView)
    }
    
}

//    MARK: - Extension

extension SearchTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let requestLocation = searchNavigationTextField.location
        
        self.viewModel.resumeFetch(searchText: requestLocation, tableView: self.tableView)
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let requestLocation = searchNavigationTextField.location
        
        self.viewModel.resumeFetch(
            searchText: requestLocation,
            tableView: self.tableView
        )
    }
}

extension SearchTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResultFilteredCities.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = String(describing: ResultTableViewCell.self)
        
        guard let cell = self.tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath) as? ResultTableViewCell
            else {
                fatalError("Fatal error \(identifier)")
        }
        
        let item = ResultFilteredCities.data[indexPath.row]
        
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
        
        let arrayCoordinate = cell.getArrayCoordinate()
        
        _ = location.popLast()
        
        self.navigationController?.pushViewController(
            Screens.main(latitude: arrayCoordinate[0], longitude: arrayCoordinate[1]),
            animated: true)
        
        ResultFilteredCities.data.removeAll()
    }
}
