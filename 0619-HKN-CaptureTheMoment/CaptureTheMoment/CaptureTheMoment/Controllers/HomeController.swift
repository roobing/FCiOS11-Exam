//
//  ViewController.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/20/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit
import CoreHaptics

final class HomeController: UIViewController {
    
    // MARK: - Properties
    let persistenceManager: PersistenceManager
    static var currentTheme: ColorTheme = .night
    var timer = Timer()
    var feedbackGenerator: UINotificationFeedbackGenerator?
    
    let welcomeString = "Don't Miss the Moment".localized
    let welcomeString2 = "Remember your day".localized
    
    private lazy var cameraBtn: CircleButton = {
        let button = CircleButton(frame: view.frame)
        button.layer.cornerRadius = view.bounds.width / 3
        button.addTarget(self, action: #selector(handleCameraBtn(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var albumBtn: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.stack")?.withTintColor(colorPalette.menuColor, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(handleAlbumBarBtn(_:)))
        return barButton
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = welcomeString
        label.textColor = colorPalette.menuColor
        label.font = UIFont.systemFont(ofSize: 27)
        label.alpha = 0
        return label
    }()
    
    private var welcomeLabelBottomAnchorConstant: NSLayoutConstraint!
    
    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.cameraFlashMode = .off
        return imagePicker
    }()
    
    private lazy var settingBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Settings", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(colorPalette.textColor, for: .normal)
        button.titleLabel?.tintColor = colorPalette.textColor
        button.addTarget(self, action: #selector(handleSettingBtn(_:)), for: .touchUpInside)
        return button
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
        defineThemes()
        colorPalette.changeColorTheme(colorTheme: HomeController.currentTheme)
        setNotification()
        persistenceManager.loadPhotoData()
        configureUI()
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = .clear
        colorPalette.changeColorTheme(colorTheme: HomeController.currentTheme)
        persistenceManager.loadPhotoData()
        restartTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resetAnimation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - UI
    private func configureUI() {
        feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator?.prepare()
        
        // Gradient
        let gradient = CAGradientLayer()
        let upperColor: CGColor = colorPalette.upperGradientColor.cgColor
        let lowerColor: CGColor = colorPalette.lowerGradientColor.cgColor
        gradient.colors = [upperColor, lowerColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        // NavigationController Settings
        navigationItem.title = "Moment"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: colorPalette.menuColor]
        navigationController?.navigationBar.tintColor = colorPalette.menuColor
        navigationItem.rightBarButtonItems = [albumBtn]
        
        // AutoLayout
        welcomeLabelBottomAnchorConstant = welcomeLabel.bottomAnchor.constraint(equalTo: cameraBtn.topAnchor, constant: -20)
        
        [cameraBtn, welcomeLabel, settingBtn].forEach() {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false }
        [
            cameraBtn.widthAnchor.constraint(equalToConstant: view.bounds.width / 1.5),
            cameraBtn.heightAnchor.constraint(equalToConstant: view.bounds.width / 1.5),
            cameraBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            cameraBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            
            settingBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            welcomeLabelBottomAnchorConstant,
            ].forEach { $0.isActive = true }
    }
    
    func configureAnimation() {
        UIView.animate( // label 등장 애니메이션
            withDuration: 1.0,
            animations: {
                self.welcomeLabelBottomAnchorConstant.constant = -50
                self.welcomeLabel.alpha = 1
                self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate( // cameraBtn 숨 쉬는 애니메이션
            withDuration: 1.0,
            delay: 0,
            options: [.autoreverse, .repeat, .allowUserInteraction],
            animations: {
                self.cameraBtn.transform = CGAffineTransform(scaleX: 1.03, y: 1.03)
        },
            completion: nil
            
        )
    }
    
    func resetAnimation() {
        welcomeLabelBottomAnchorConstant.constant = -20
        welcomeLabel.alpha = 0
        welcomeLabel.text = welcomeString
        cameraBtn.transform = CGAffineTransform(scaleX: 1.00, y: 1.00)
    }
    
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDidEnterBackgroundNotification), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleWillEnterForegroundNotification), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    
    
    // MARK: - Selectors
    @objc private func handleCameraBtn(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        feedbackGenerator?.notificationOccurred(.success)
        present(imagePicker, animated: true)
    }
    
    @objc private func handleAlbumBarBtn(_ sender: UIBarButtonItem) {
        let nextVC = UINavigationController(rootViewController: AlbumCollectionController(persistenceManager: persistenceManager))
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .coverVertical
        present(nextVC, animated: true)
    }
    
    @objc private func handleSettingBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "테마 선택", message: "원하는 테마를 선택하세요. \n 새로운 테마는 다음 앱 실행 시부터 적용됩니다.", preferredStyle: .actionSheet)
        let morningAction = UIAlertAction(title: "Morning", style: .default, handler: {_ in
            HomeController.currentTheme = .morning
            UserDefaults.standard.set("Morning", forKey: "theme")
            self.presentRestartAlert()
        })
        let afternoonAction = UIAlertAction(title: "Afternoon", style: .default, handler: {_ in
            HomeController.currentTheme = .afternoon
            UserDefaults.standard.set("Afternoon", forKey: "theme")
            self.presentRestartAlert()
        })
        let eveningAction = UIAlertAction(title: "Evening", style: .default, handler: {_ in
            HomeController.currentTheme = .evening
            UserDefaults.standard.set("Evening", forKey: "theme")
            self.presentRestartAlert()
        })
        let nightAction = UIAlertAction(title: "Night", style: .default, handler: {_ in
            UserDefaults.standard.set("Night", forKey: "theme")
            self.presentRestartAlert()
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        [morningAction, afternoonAction, eveningAction, nightAction, cancelAction].forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
    
    // notifications
    @objc func handleDidEnterBackgroundNotification() {
        resetAnimation()
    }
    
    @objc func handleWillEnterForegroundNotification() {
        configureAnimation()
        restartTimer()
    }
    
    
    // MARK: - Methods
    
    private func defineThemes() {
        switch UserDefaults.standard.string(forKey: "theme") {
        case "Morning":
            HomeController.currentTheme = .morning
        case "Afternoon":
            HomeController.currentTheme = .afternoon
        case "Evening":
            HomeController.currentTheme = .evening
        case "Night":
            HomeController.currentTheme = .night
        default:
            HomeController.currentTheme = .night
        }
    }
    
    private func presentRestartAlert() {
        let alert = UIAlertController(title: "재시작", message: "테마 적용을 위해 앱을 재시작하겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "확인", style: .destructive, handler: { _ in exit(-1) })
        [cancelAction, confirmAction].forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
    
    private func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 6.5, repeats: true, block: { _ in
            UIView.transition(
                with: self.welcomeLabel,
                duration: 0.75,
                options: [.transitionCrossDissolve],
                animations: {
                    self.welcomeLabel.text = self.welcomeLabel.text == self.welcomeString ? self.welcomeString2 : self.welcomeString
            },
                completion: nil)
        })
    }
    
    private func restartTimer() {
        timer.invalidate()
        startTimer()
    }
}


// MARK: - UIImagePickerControllerDelegate
extension HomeController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalImage = info[.originalImage] as! UIImage
        let editedImage = info[.editedImage] as? UIImage
        let selectedImage = editedImage ?? originalImage
        
        if selectedImage == editedImage {
            print("editedImg")
        } else {
            print("else")
        }
        
        let rc = RegisterController(persistenceManager: persistenceManager)
        rc.imageFromPicker = selectedImage
        
        picker.dismiss(animated: true, completion: {
            let rc = RegisterController(persistenceManager: PersistenceManager.shared)
            rc.imageFromPicker = selectedImage
            self.navigationController?.modalTransitionStyle = .coverVertical
            self.navigationController?.pushViewController(rc, animated: true)
        })
    }
    
}


// MARK: - UINavigationControllerDelegate
extension HomeController: UINavigationControllerDelegate {
    
}
