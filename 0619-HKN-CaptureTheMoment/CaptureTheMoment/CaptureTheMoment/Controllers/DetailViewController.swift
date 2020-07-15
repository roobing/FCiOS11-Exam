//
//  DetailViewController.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/20/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    let persistenceManager: PersistenceManager
    
    var image: UIImage = UIImage()
    var selectedIndexPath: IndexPath = []
    
    lazy var imageViewer: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = view.bounds.width / 15
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var commentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Comment"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = colorPalette.menuColor
        label.layer.borderColor = UIColor.clear.cgColor
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = colorPalette.menuColor
        label.numberOfLines = 0
        label.layer.borderColor = UIColor.clear.cgColor
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var commentLabelPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "저장된 코멘트가 없습니다"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = colorPalette.menuColor.withAlphaComponent(0.8)
        label.alpha = 0
        label.numberOfLines = 0
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.clear.cgColor
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = colorPalette.menuColor
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.clear.cgColor
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = colorPalette.menuColor
        label.numberOfLines = 0
        label.layer.borderColor = UIColor.clear.cgColor
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var locationLabelPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "저장된 장소 정보가 없습니다"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = colorPalette.menuColor.withAlphaComponent(0.8)
        label.alpha = 0
        label.numberOfLines = 0
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.clear.cgColor
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var editBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "pencil.tip"), style: .plain, target: self, action: #selector(handleEditBtn(_:)))
        return button
    }()
    
    private lazy var returnBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "arrow.down.right.and.arrow.up.left"), style: .plain, target: self, action: #selector(handleReturnBtn(_:)))
        return button
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    
    // MARK: - UI
    init(persistenceManager: PersistenceManager) {
        self.persistenceManager = persistenceManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Memory"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: colorPalette.menuColor]
        navigationController?.navigationBar.tintColor = colorPalette.menuColor
        
        navigationItem.leftBarButtonItems = [returnBtn]
        navigationItem.rightBarButtonItems = [editBtn]
        
        // Gradient
        let gradient = CAGradientLayer()
        let upperColor: CGColor = colorPalette.upperGradientColor.cgColor
        let lowerColor: CGColor = colorPalette.lowerGradientColor.cgColor
        gradient.colors = [upperColor, lowerColor]
        gradient.locations = [0 ,0.70]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        [imageViewer, commentTitleLabel, commentLabel, commentLabelPlaceholder, locationTitleLabel, locationLabel, locationLabelPlaceholder].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let spacing: CGFloat = 16
        [
            // imageViewer Layout
            imageViewer.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageViewer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: spacing),
            imageViewer.widthAnchor.constraint(equalToConstant: view.bounds.width - spacing * 3.5),
            imageViewer.heightAnchor.constraint(equalToConstant: view.bounds.height * 3 / 7),
            
            // comment Layout
            commentTitleLabel.topAnchor.constraint(equalTo: imageViewer.bottomAnchor, constant: spacing * 2),
            commentTitleLabel.leadingAnchor.constraint(equalTo: imageViewer.leadingAnchor, constant: 0),
            commentTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            commentLabel.topAnchor.constraint(equalTo: commentTitleLabel.bottomAnchor, constant: spacing / 3),
            commentLabel.leadingAnchor.constraint(equalTo: imageViewer.leadingAnchor, constant: 0),
            commentLabel.trailingAnchor.constraint(equalTo: imageViewer.trailingAnchor, constant: 0),
            
            commentLabelPlaceholder.topAnchor.constraint(equalTo: commentTitleLabel.bottomAnchor, constant: spacing / 3),
            commentLabelPlaceholder.leadingAnchor.constraint(equalTo: imageViewer.leadingAnchor, constant: 0),
            commentLabelPlaceholder.trailingAnchor.constraint(equalTo: imageViewer.trailingAnchor, constant: 0),
            
            // location Layout
            locationTitleLabel.topAnchor.constraint(equalTo: commentTitleLabel.bottomAnchor, constant: spacing * 3),
            locationTitleLabel.leadingAnchor.constraint(equalTo: imageViewer.leadingAnchor, constant: 0),
            locationTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            locationLabel.topAnchor.constraint(equalTo: locationTitleLabel.bottomAnchor, constant: spacing / 3),
            locationLabel.leadingAnchor.constraint(equalTo: imageViewer.leadingAnchor, constant: 0),
            locationLabel.trailingAnchor.constraint(equalTo: imageViewer.trailingAnchor, constant: 0),
            
            locationLabelPlaceholder.topAnchor.constraint(equalTo: locationTitleLabel.bottomAnchor, constant: spacing / 3),
            locationLabelPlaceholder.leadingAnchor.constraint(equalTo: imageViewer.leadingAnchor, constant: 0),
            locationLabelPlaceholder.trailingAnchor.constraint(equalTo: imageViewer.trailingAnchor, constant: 0),
            ].forEach { $0.isActive = true }
        
        checkLocationInfo()
        setImage()
    }
    
    // MARK: - Selectors
    @objc private func handleEditBtn(_ sender: UIBarButtonItem) {
        let targetedVC = EditingViewController(persistenceManager: persistenceManager)
        let nextVC = UINavigationController(rootViewController: targetedVC)
        
        targetedVC.selectedIndexPath = self.selectedIndexPath
        targetedVC.commentTextField.text = commentLabel.text
        targetedVC.locationTextField.text = locationLabel.text
        
        present(nextVC, animated: true, completion: nil)
    }
    
    @objc private func handleReturnBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Private Methods
    func setImage() {
        imageViewer.image = image
    }
    
    private func checkLocationInfo() {
        if locationLabel.text?.isEmpty == true {
            locationLabelPlaceholder.alpha = 1
        }
        if commentLabel.text?.isEmpty == true {
            commentLabelPlaceholder.alpha = 1
        }
    }
}
