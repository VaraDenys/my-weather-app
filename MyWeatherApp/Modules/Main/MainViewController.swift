//
//  MainViewController.swift
//  MyWeatherApp
//
//  Created by Deny Vorko on 31.01.2021.
//  Copyright © 2021 Denys Vorko. All rights reserved.
//

import UIKit
import SnapKit
import Moya



class MainViewController: ViewController<MainViewModel> {
    
    //    MARK: - Private properties
    
    private let topView = TopView()
    
    private let collectionViewLayout = UICollectionViewFlowLayout()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    private let tableView = UITableView()
    
    private let changeLocation: NSKeyValueObservation? = nil
    
    //    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

}   
    
    //    MARK: - Override func
    
    override func setupConstraints() {
        super.setupConstraints()
        view.addSubview(topView)
        view.addSubview(collectionView)
        view.addSubview(tableView)
        
        topView.snp.makeConstraints({ [weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.topLayoutGuide.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().inset(16)
            $0.height.equalTo(250)
        })
        
        collectionView.snp.makeConstraints({
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(150)
        })
        
        tableView.snp.makeConstraints({
            $0.top.equalTo(collectionView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
    
    override func setupView() {
        super.setupView()
        
        view.backgroundColor = Colors.appBackground
        
        topView.configure(location: self.viewModel.getLocation(), date: "Fri, 20 july")
        topView.cityNameTextField.delegate = self
    }
    
    override func setupCollectionView() {
        super.setupCollectionView()
        
        collectionView.register(
            HourlyCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: HourlyCollectionViewCell.self))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = Colors.collectionBackground
        collectionView.indicatorStyle = .white
        
        collectionViewLayout.scrollDirection = .horizontal
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        tableView.register(
            DayForecastCell.self,
            forCellReuseIdentifier: String(describing: DayForecastCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
    }
    
    func pushViewController(location: String) {
        navigationController?.pushViewController(Screens.search(location: location), animated: true)
    }
    
    //      MARK: - User interaction
    
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: HourlyCollectionViewCell.self)
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
            ) as? HourlyCollectionViewCell else {
                fatalError("Can't find cell with identifier \(identifier)")
        }
        
        let hourlyItem = viewModel.getHourlyItem(for: indexPath)
        cell.configure(hourlyItem)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 150)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDayForecastCount()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: DayForecastCell.self)
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
            ) as? DayForecastCell else {
                fatalError("Fatal error \(identifier)")
        }
        
        let item = viewModel.getDaylyItem(for: indexPath)
        cell.configure(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DayForecastCell else { return }
        cell.setSelectColorAndShadow(isSelected: cell.isSelected)
    }
    
    func tableView(_ tableView: UITableView,
                   didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DayForecastCell else { return }
        cell.setSelectColorAndShadow(isSelected: cell.isSelected)
    }
}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        navigationController?.view.layer.add(transition, forKey: nil)
        
        navigationController?.pushViewController(
            Screens.search(location: self.topView.cityNameTextField.text ?? ""),
            animated: false
        )
        
        textField.endEditing(true)
    }
    
}
