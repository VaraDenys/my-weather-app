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
import Reachability

class MainViewController: ViewController<MainViewModel> {
    
    // MARK: - Private properties
    
    private let topView = TopView()
    
    private let locationButton = UIBarButtonItem()
    
    private let locationTitleButton = LocationSearchBar()
    
    private let targetButton = UIBarButtonItem()
    
    private let collectionViewLayout = UICollectionViewFlowLayout()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    private let tableView = UITableView()
    
    private let manager = CLLocationManager()
    
    // MARK: - Override init, deinit
    
    override init(viewModel: MainViewModel) {
        super.init(viewModel: viewModel)
        
        try? addReachabilityObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.chekLocationEnabled()
        self.checkAutorization()
        self.setupLocation()
        
        super.viewDidAppear(animated)
    }
    
    // MARK: - Override func
    
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
    }
    
    override func setupCollectionView() {
        super.setupCollectionView()
        
        collectionView.register(
            HourlyCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: HourlyCollectionViewCell.self)
        )
        
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
            forCellReuseIdentifier: String(describing: DayForecastCell.self)
        )
        
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
    
    override func setupLocation() {
        super.setupLocation()
        
        guard let lat = self.viewModel.getCoordinate().lat, let long = self.viewModel.getCoordinate().long else {
            
            self.manager.desiredAccuracy = kCLLocationAccuracyBest
            
            self.manager.startUpdatingLocation()
            
            guard let lat = self.manager.location?.coordinate.latitude else { return }
            guard let long = self.manager.location?.coordinate.longitude else { return }
            
            self.viewModel.resumeFetch(lat: lat, long: long)
            return
        }
        
        self.viewModel.resumeFetch(lat: lat, long: long)
    }
    
    override func binding() {
        
        self.viewModel.onDidChangeValues = { [weak self] in
            
            guard let topViewType = self?.viewModel.getTopViewType() else { return }
            
            self?.topView.configure(
                date: topViewType.date,
                image: topViewType.image,
                temp: topViewType.temperature,
                humid: topViewType.humidity,
                wind: topViewType.wind
            )
            
            self?.locationTitleButton.setTitle(location: topViewType.location)
            
            self?.tableView.reloadData()
            self?.collectionView.reloadData()
        }
        
        self.viewModel.onDidError = { [weak self] (error) in
            
            guard let self = self else { return }
            
            switch error {
            case .internetDisconnect:
                
                self.showAlert(
                    title: "No internet connection",
                    message: "Go to settings and enable",
                    cancelTitle: "Ok",
                    actionTitle: "Settings") { (action) in
                        
                        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                        
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case .invalidRequest:
                // something to do
                break
            case .invalidValues:
                // something to do
                break
            default:
                break
            }
            
        }
        
        locationButton.target = self
        locationButton.action = #selector(actionLocationButton(sender:))
        
        locationTitleButton.addTarget(self, action: #selector(actionTitleButton(sender:)), for: .touchUpInside)
        
        targetButton.target = self
        targetButton.action = #selector(actionTargetButton(sender:))
    }
    
    // MARK: - Private func
    
    private func chekLocationEnabled() {
        if !CLLocationManager.locationServicesEnabled() {
            
            self.showAlert(
                title: "Location serice disabled",
                message: "Go to Settings and to turn it on",
                cancelTitle: "Ok",
                actionTitle: "Settings") { (alert) in
                    
                    guard let url = URL(string: "App-Prefs:root=LOCATION_SERVICES") else { return }
                    
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    private func checkAutorization() {
        
        switch CLLocationManager.authorizationStatus() {
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            
        case .denied:
            
            self.showAlert(
                title: "You have denied the use of the location",
                message: "Want to change it?",
                cancelTitle: "No",
                actionTitle: "Settings"
            ) { (action) in
                
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        default:
            break
        }
    }
    
    // MARK: - User interaction
    
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
                    location: self.locationTitleButton.getTitle()),
                animated: false)
    }
    
    @objc func actionTargetButton(sender: UIBarButtonItem) {
        
        self.chekLocationEnabled()
        
        self.checkAutorization()
        
        try? self.addReachabilityObserver()
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.startUpdatingLocation()
        
        guard let lat = manager.location?.coordinate.latitude else { return }
        guard let lon = manager.location?.coordinate.longitude else { return }
        
        self.viewModel.resumeFetch(lat: lat, long: lon)
    }
}

// MARK: - Extension

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
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
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
}

extension MainViewController: ReachabilityObserverDelegate {
    
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
