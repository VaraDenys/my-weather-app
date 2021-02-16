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
    
    private let stackView = UIStackView()
    
    private let backButton = UIButton()
    
    private let textField = TextField()
    
    private let loupeButton = UIButton()
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.resumeFetch(searchText: "huy", tableView: self.tableView)
        }

    override func setupConstraints() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(loupeButton)
        view.addSubview(tableView)
        
        stackView.snp.makeConstraints({
            $0.top.equalTo(self.topLayoutGuide.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        })
        
        backButton.snp.makeConstraints({
            $0.width.equalTo(self.backButton.snp.height)
        })
        
        loupeButton.snp.makeConstraints({
            $0.width.equalTo(self.loupeButton.snp.height)
        })
        
        tableView.snp.makeConstraints({
            $0.top.equalTo(stackView.snp.bottom).offset(16)
            $0.left.right.bottom.equalToSuperview()
        })
    }
    
    override func setupView() {
        
        view.backgroundColor = Colors.appBackground
        
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        backButton.setImage(Images.backButton.get().withRenderingMode(.alwaysTemplate), for: .normal) 
        backButton.backgroundColor = Colors.appBackground
        backButton.tintColor = Colors.lightTintColorImage
        backButton.contentMode = .scaleAspectFit
        
        textField.backgroundColor = Colors.lightFont
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: 20)
        textField.text = "Zaporizhzhia"
        textField.textColor = Colors.darkFont
        textField.becomeFirstResponder()
        textField.layer.cornerRadius = 3
        textField.setEdgePadding(8)
        textField.delegate = self
        
        loupeButton.setImage(Images.searchBarLoupe.get().withRenderingMode(.alwaysTemplate), for: .normal)
        loupeButton.tintColor = Colors.lightTintColorImage
        loupeButton.backgroundColor = Colors.appBackground
        loupeButton.contentMode = .scaleAspectFit
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
    
    override func binding() {
        
        backButton.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        
        loupeButton.addTarget(self, action: #selector(loupeAction(sender:)), for: .touchUpInside)
    }
    
    @objc func backAction(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func loupeAction(sender: UIButton) {
        self.viewModel.resumeFetch(searchText: self.textField.text ?? "", tableView: self.tableView)
    }
    
}

extension SearchTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.viewModel.resumeFetch(searchText: textField.text ?? "", tableView: self.tableView)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.viewModel.resumeFetch(searchText: textField.text ?? "", tableView: self.tableView)
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
        
        cell.configure(nameCity: item.nameCities, nameCountry: item.nameCountry)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: ResultTableViewCell.self),
            for: indexPath) as? ResultTableViewCell else {
                fatalError("No find cell")
        }
        
        
        
        let location = cell.getCityName()
        
        debugPrint(location)
        
        self.navigationController?.pushViewController(Screens.main(location: location), animated: true)
    }
}
