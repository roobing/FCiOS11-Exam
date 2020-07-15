//
//  RegisterController.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/20/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit
import MapKit

final class RegisterController: UIViewController {
    
    // MARK: - Properties
    let persistenceManager: PersistenceManager
    
    let locationManager = CLLocationManager()
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemBackground
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        image.contentMode = .scaleAspectFit
        return image
    }()
    var imageFromPicker: UIImage = UIImage()
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelAction(_:)))
        return button
    }()
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveAction(_:)))
        return button
    }()
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "아래 버튼을 눌러 장소를 추가하세요"
        label.textAlignment = .center
        label.textColor = colorPalette.textColor
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    lazy var locationButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "location.circle")?.withTintColor(colorPalette.backgourndColor, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setTitle(" 내 위치 찾기", for: .normal)
        button.setTitleColor(colorPalette.backgourndColor, for: .normal)
        button.backgroundColor = colorPalette.buttonColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(locationUpdate(_:)), for: .touchUpInside)
        return button
    }()
    lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    lazy var contentTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.preferredFont(forTextStyle: .body)
        tv.backgroundColor = .clear
        tv.textColor = colorPalette.menuColor
        tv.layer.cornerRadius = 5
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return tv
    }()
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Comment..."
        label.textColor = .lightGray
        return label
    }()
    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = .white
        indicatorView.hidesWhenStopped = true // 애니메이션이 끝났을 때 숨겨짐
        return indicatorView
    }()
    
    
    // MARK: - Lifecycle
    init(persistenceManager: PersistenceManager) {
        self.persistenceManager = persistenceManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setConstraint()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contentTextView.becomeFirstResponder()
    }
    
    // MARK: - UI
    
    func setConstraint() {
        let spacing: CGFloat = 16
        let safeArea = view.safeAreaLayoutGuide
        
        [imageView, contentTextView, divider, locationButton, locationLabel, placeholderLabel, indicatorView].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        [imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: spacing * 2),
         imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
         imageView.widthAnchor.constraint(equalToConstant: 150),
         imageView.heightAnchor.constraint(equalToConstant: 200),
         
         contentTextView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: spacing * 2),
         contentTextView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
         contentTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
         contentTextView.heightAnchor.constraint(equalToConstant: 200),
         
         placeholderLabel.topAnchor.constraint(equalTo: contentTextView.topAnchor, constant: 10),
         placeholderLabel.leadingAnchor.constraint(equalTo: contentTextView.leadingAnchor, constant: 16),
         
         locationLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
         locationLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
         locationLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
         locationLabel.heightAnchor.constraint(equalToConstant: 30),
         
         divider.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
         divider.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
         divider.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: spacing),
         divider.heightAnchor.constraint(equalToConstant: 1),
         
         locationButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 15),
         locationButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
         locationButton.widthAnchor.constraint(equalToConstant: 170),
         locationButton.heightAnchor.constraint(equalToConstant: 60),
         
         indicatorView.centerXAnchor.constraint(equalTo: locationButton.centerXAnchor, constant: 0),
         indicatorView.centerYAnchor.constraint(equalTo: locationButton.centerYAnchor, constant: 0)].forEach({$0.isActive = true})
    }
    
    private func setUI() {
        
        // view
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        // Gradient
        let gradient = CAGradientLayer()
        let upperColor: CGColor = colorPalette.upperGradientColor.cgColor
        let lowerColor: CGColor = colorPalette.lowerGradientColor.cgColor
        gradient.colors = [upperColor, lowerColor]
        gradient.locations = [0 ,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        // imageView
        imageView.image = imageFromPicker
        view.addSubview(imageView)
        
        // contentTextView
        contentTextView.delegate = self
        view.addSubview(contentTextView)
        
        // placeholder
        view.addSubview(placeholderLabel)
        
        // locationLabel
        view.addSubview(locationLabel)
        
        // divider
        view.addSubview(divider)
        
        // locationButton
        locationManager.delegate = self
        view.addSubview(locationButton)
        
        // indicator view
        locationButton.addSubview(indicatorView)
        
        // navigation
        navigationItem.title = "Memory"
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = colorPalette.menuColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    // MARK: - Selectors
    @objc func cancelAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveAction(_ sender: UIButton) {
        persistenceManager.saveData(imageView: imageView, textView: contentTextView, locationLabel: locationLabel)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func locationUpdate(_ sender: UIButton) {
        checkAuthorizationStatus()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // MARK: - Location
    func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() { // 권한 상태 체크
        case .notDetermined: // 사용자에게 물어봐야하는 상황
            locationManager.requestWhenInUseAuthorization() // 사용자에게 창을 띄워 권한 요청
        case .restricted, .denied: break // 거절되어 있는 상태
        case .authorizedWhenInUse: // When in use 허용되어 있는 상태
            fallthrough
        case .authorizedAlways: // always 허용되어 있는 상태
            startUpdatingLocation()
        @unknown default: fatalError() // 언노운은 개발자에게 알려주는 용도. 나중에 케이스가 추가될지도 모르는부분
        }
    }
    
    func startUpdatingLocation() {
        let status = CLLocationManager.authorizationStatus() // 권한 상태 체크
        guard status == .authorizedAlways || status == .authorizedWhenInUse, // when in use 또는 always이고 location services가 이용가능이면
            CLLocationManager.locationServicesEnabled()
            else { return }
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10.0
        locationManager.requestLocation()
        
        indicatorView.startAnimating()
        locationButton.setImage(UIImage(systemName: ""), for: .normal)
        locationButton.setTitle("", for: .normal)
    }
}


// MARK: - UITextVIewDelegate
extension RegisterController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
            // save text
        }
    }
}


// MARK: - CLLocationManagerDelegate
extension RegisterController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status { // 사용 권한 상태에 따라
        case .authorizedWhenInUse, .authorizedAlways:
            print("Authorized")
        default:
            print("Unauthorized")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let current = locations.last!
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(current) { placeMark, error in
            if error != nil {
                return print(error!.localizedDescription)
            }
            
            // 국가별 주소체계에 따라 어떤 속성 값을 가질지 다름
            guard let address = placeMark?.first, // placeMark의 첫번째 요소에 들어있는 주소를 꺼내옴
                let country = address.country,
                let administrativeArea = address.administrativeArea,
                let locality = address.locality,
                let name = address.name
                else { return }
            
            self.locationLabel.text = "\(country) \(administrativeArea) \(locality) \(name)"
        }
        // 위치 찾기 버튼 재구성 및 인디케이터 정지
        locationButton.setTitle("내 위치 찾기", for: .normal)
        locationButton.setImage(UIImage(systemName: "location.circle"), for: .normal)
        indicatorView.stopAnimating()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        fatalError("error")
    }
}

