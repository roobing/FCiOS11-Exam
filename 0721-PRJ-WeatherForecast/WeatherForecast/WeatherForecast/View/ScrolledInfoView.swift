//
//  ScrolledInfoView.swift
//  WeatherForecast
//
//  Created by Woobin Cheon on 2020/07/22.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class ScrolledInfoView: UIView {
    
    let clearView = UIView()
    let currentInfoView = UIView()
    let forecastInfoTableView = UITableView()
    
    let conditionInfoLabel = UILabel()
    let conditionInfoStackView = UIStackView()
    let conditionImage = UIImageView()
    let conditionLabel = UILabel()
    
    let lowHighTempInfoStackView = UIStackView()
    let lowTempImage = UIImageView()
    let lowTempLabel = UILabel()
    let highTempImage = UIImageView()
    let highTempLabel = UILabel()
    
    let currentTempInfoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupCurrentInfoUI()
        setupConstraint()
        setupCurrentInfoConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
//        clearView.backgroundColor = .systemYellow
        
//        currentInfoView.backgroundColor = .systemTeal
        
        forecastInfoTableView.dataSource = self
        forecastInfoTableView.delegate = self
        forecastInfoTableView.rowHeight = 80
        forecastInfoTableView.backgroundColor = .clear
        
    }
    
    func setupCurrentInfoUI() {
//        let attributedString = NSMutableAttributedString()
//        let imageAttachement = NSTextAttachment()
//        imageAttachement.image = UIImage(named: "01d")
//        imageAttachement.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
//        attributedString.append(NSAttributedString(attachment: imageAttachement))
//        attributedString.append(NSAttributedString(string: "맑음"))
//        conditionInfoLabel.attributedText = attributedString
//        conditionInfoLabel.font = UIFont.systemFont(ofSize: 22)
//        conditionInfoLabel.backgroundColor = .red
//        conditionInfoLabel.baselineAdjustment = .alignCenters
//        conditionInfoLabel.sizeToFit()
        
        conditionImage.image = UIImage(named: "01d")
        conditionImage.frame.size = CGSize(width: 40, height: 40)
        conditionImage.contentMode = .scaleAspectFit
        conditionLabel.text = "맑음"
        conditionLabel.textColor = .white
        conditionLabel.baselineAdjustment = .alignBaselines
//        conditionLabel.backgroundColor = .red
        
        conditionInfoStackView.backgroundColor = .systemPink
        conditionInfoStackView.addArrangedSubview(conditionImage)
        conditionInfoStackView.addArrangedSubview(conditionLabel)
        
        lowTempImage.image = UIImage(systemName: "arrow.down.to.line")
        lowTempImage.tintColor = .white
        lowTempLabel.text = "22℃"
        lowTempLabel.textColor = .white
        highTempImage.image = UIImage(systemName: "arrow.up.to.line")
        highTempImage.tintColor = .white
        highTempLabel.text = "35℃"
        highTempLabel.textColor = .white
        lowHighTempInfoStackView.backgroundColor = .systemGreen
        lowHighTempInfoStackView.addArrangedSubview(lowTempImage)
        lowHighTempInfoStackView.addArrangedSubview(lowTempLabel)
        lowHighTempInfoStackView.addArrangedSubview(highTempImage)
        lowHighTempInfoStackView.addArrangedSubview(highTempLabel)
        
        currentTempInfoLabel.text = "19.2℃"
        currentTempInfoLabel.textColor = .white
        currentTempInfoLabel.font = UIFont.systemFont(ofSize: 120)
    }
    
    func setupConstraint() {
        [clearView, currentInfoView, forecastInfoTableView].forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        })
        
        NSLayoutConstraint.activate([
            
            clearView.topAnchor.constraint(equalTo: self.topAnchor),
            clearView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.6),
            
            currentInfoView.topAnchor.constraint(equalTo: clearView.bottomAnchor),
            currentInfoView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.3),
            
            forecastInfoTableView.topAnchor.constraint(equalTo: currentInfoView.bottomAnchor),
            forecastInfoTableView.heightAnchor.constraint(equalToConstant: forecastInfoTableView.rowHeight * 10),
            forecastInfoTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupCurrentInfoConstraint() {
//        [conditionInfoLabel].forEach({
//            currentInfoView.addSubview($0)
//
//            $0.translatesAutoresizingMaskIntoConstraints = false
//
//            $0.topAnchor.constraint(equalTo: currentInfoView.topAnchor).isActive = true
//            $0.leadingAnchor.constraint(equalTo: currentInfoView.leadingAnchor).isActive = true
//        })
        
        [conditionInfoStackView, lowHighTempInfoStackView, currentTempInfoLabel].forEach({
            currentInfoView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        NSLayoutConstraint.activate([
            conditionInfoStackView.topAnchor.constraint(equalTo: currentInfoView.topAnchor),
            conditionInfoStackView.leadingAnchor.constraint(equalTo: currentInfoView.leadingAnchor),
            conditionInfoStackView.heightAnchor.constraint(equalToConstant: 40),
            
            lowHighTempInfoStackView.topAnchor.constraint(equalTo: conditionInfoStackView.bottomAnchor),
            lowHighTempInfoStackView.leadingAnchor.constraint(equalTo: currentInfoView.leadingAnchor),
            lowHighTempInfoStackView.heightAnchor.constraint(equalToConstant: 40),
            
            currentTempInfoLabel.topAnchor.constraint(equalTo: lowHighTempInfoStackView.bottomAnchor),
            currentTempInfoLabel.leadingAnchor.constraint(equalTo: currentInfoView.leadingAnchor)
//            lowHighTempInfoStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Selector
    @objc func weatherInfoReload(_ sender: UIBarButtonItem) {
        print("Weahter Info Reload...")
    }
    
    
}

extension ScrolledInfoView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("1")
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.imageView?.image = UIImage(named: "01d")
        cell.textLabel?.text = "5.29(월)"
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.text = "12:00"
        cell.detailTextLabel?.textColor = .white
        cell.accessoryType = .checkmark
        cell.backgroundColor = .clear
        
        return cell
    }
    
    
}

extension ScrolledInfoView: UITableViewDelegate {
    
}
