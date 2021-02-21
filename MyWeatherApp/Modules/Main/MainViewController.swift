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
import CoreLocation


class MainViewController: ViewController<MainViewModel> {
    
    //    MARK: - Private properties
    
    private let topView = TopView()
    
    private let locationButton = UIBarButtonItem()
    
    private let locationTitleButton = LocationSearchBar()
    
    private let targetButton = UIBarButtonItem()
    
    private let collectionViewLayout = UICollectionViewFlowLayout()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    private let tableView = UITableView()
    
    private let manager = CLLocationManager()
    
    //    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.viewModel.onDidChangeLocation = { location in
            self.locationTitleButton.setTitle(location: location)
            
            self.viewModel.onDidChangeValue = { topViewType in
                DispatchQueue.main.async {
                    self.configureTopView(topViewType.date,
                                          topViewType.image,
                                          topViewType.temperature,
                                          topViewType.humidity,
                                          topViewType.wind)
                }
            }
        }
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
        
        manager.delegate = self
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
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        self.navigationItem.leftBarButtonItem = locationButton
        
        locationButton.image = Images.locationIcon.get().resized(to: CGSize(width: 25, height: 25)).withRenderingMode(.alwaysTemplate)
        locationButton.tintColor = Colors.lightTintColorImage
        
        self.navigationItem.titleView = locationTitleButton
        
        self.navigationItem.rightBarButtonItem = targetButton
        
        targetButton.image = Images.targetIcon.get().resized(to: CGSize(width: 25, height: 25)).withRenderingMode(.alwaysTemplate)
        targetButton.tintColor = Colors.lightTintColorImage
    }
    
    override func binding() {
        
        locationButton.target = self
        locationButton.action = #selector(actionLocationButton(sender:))
        
        locationTitleButton.addTarget(self, action: #selector(actionTitleButton(sender:)), for: .touchUpInside)
        
        targetButton.target = self
        targetButton.action = #selector(actionTargetButton(sender:))
    }
    
    override func setupLocation() {
        
        if self.viewModel.lat == nil || self.viewModel.long == nil {
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        manager.stopUpdatingLocation()
        
        guard let lat = manager.location?.coordinate.latitude else { return }
        guard let long = manager.location?.coordinate.longitude else { return }
        
            debugPrint("\(lat)\(long)")
            
        self.viewModel.resumeFetch(
            lat: lat,
            long: long)
        
        self.viewModel.requestDaylyForecast(
            lat: lat,
            long: long,
            tableView: self.tableView
        )
            
        } else {
            
            guard let lat = self.viewModel.lat else { return }
            guard let long = self.viewModel.long else { return }
            
            debugPrint("\(lat),\(long)")
            
            self.viewModel.resumeFetch(lat: lat, long: long)
            self.viewModel.requestDaylyForecast(lat: lat, long: long, tableView: self.tableView)
        }
    }
    
    //      MARK: - Public Func
    
    public func configureTopView(
        _ date: String,
        _ image: String,
        _ temp: String,
        _ humid: String,
        _ wind: String
    ) {
        self.topView.configure(date, image, temp, humid, wind)
    }
    
    //      MARK: - User interaction
    
    @objc func actionLocationButton(sender: UIBarButtonItem) {
        
        self.navigationController?.pushViewController(Screens.map(), animated: true)
    }
    
    @objc func actionTitleButton(sender: UIControl) {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        navigationController?.view.layer.add(transition, forKey: nil)
        
        self.navigationController?
            .pushViewController(
                Screens.search(
                    location: self.locationTitleButton.location),
                animated: true)
        
    }
    
    @objc func actionTargetButton(sender: UIBarButtonItem) {
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestWhenInUseAuthorization()
        
        manager.startUpdatingLocation()
        
        manager.stopUpdatingLocation()
        
        guard let lat = manager.location?.coordinate.latitude else { return }
        guard let lon = manager.location?.coordinate.longitude else { return }
        
        self.viewModel.resumeFetch(lat: lat, long: lon)
        self.viewModel.requestDaylyForecast(lat: lat, long: lon, tableView: self.tableView)
        self.viewModel.requestForecastHourly(lat: lat, long: lon, collectionView: self.collectionView)
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.hourlyItemCount()
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

extension MainViewController: CLLocationManagerDelegate {
    
    
}
