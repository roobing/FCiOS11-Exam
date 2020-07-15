//
//  EditingViewController.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/24/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController {
    
    let persistenceManager: PersistenceManager
    var selectedIndexPath: IndexPath = []
    var commentTitleLabelBottomAnchor: NSLayoutConstraint!
    var locationTitleLabelBottomAnchor: NSLayoutConstraint!
    
    lazy var cancelBtn: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelBtn(_:)))
        return barButton
    }()
    
    lazy var saveBtn: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveBtn(_:)))
        return barButton
    }()
    
    private lazy var commentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Comment"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = colorPalette.textColor
        label.alpha = commentTextField.text!.isEmpty ? 0 : 1
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.clear.cgColor
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var commentTextField: UITextField = {
        let textField = UITextField()
        textField.text = ""
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.textColor = colorPalette.textColor
        //        textField.placeholder = "Comment"
        textField.attributedPlaceholder = NSAttributedString(string: "Comment", attributes: [NSAttributedString.Key.foregroundColor: colorPalette.textColor.withAlphaComponent(0.8)])
        textField.delegate = self
        textField.clearButtonMode = .whileEditing
        textField.keyboardAppearance = .dark
        textField.becomeFirstResponder()
        return textField
    }()
    
    private lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = colorPalette.textColor
        label.alpha = commentTextField.text!.isEmpty ? 0 : 1
        label.layer.borderColor = UIColor.clear.cgColor
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var locationTextField: UITextField = {
        let textField = UITextField()
        textField.text = ""
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.textColor = colorPalette.textColor
        //        textField.placeholder = "Comment"
        textField.attributedPlaceholder = NSAttributedString(string: "Location", attributes: [NSAttributedString.Key.foregroundColor: colorPalette.textColor.withAlphaComponent(0.8)])
        textField.delegate = self
        textField.clearButtonMode = .whileEditing
        textField.keyboardAppearance = .dark
        textField.becomeFirstResponder()
        return textField
    }()
    
    lazy var deleteLineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    lazy var deleteBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("이미지 삭제하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        button.addTarget(self, action: #selector(handleDeleteBtn(_:)), for: .touchUpInside)
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
        configureUI()
        print(selectedIndexPath)
    }
    
    
    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = colorPalette.upperGradientColor
        navigationItem.title = "Edit"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: colorPalette.menuColor]
        navigationController?.navigationBar.tintColor = colorPalette.menuColor
        navigationItem.leftBarButtonItems = [cancelBtn]
        navigationItem.rightBarButtonItems = [saveBtn]
        
        // Gradient
        let gradient = CAGradientLayer()
        let upperColor: CGColor = colorPalette.upperGradientColor.cgColor
        let lowerColor: CGColor = colorPalette.lowerGradientColor.cgColor
        gradient.colors = [upperColor, lowerColor]
        gradient.locations = [0 ,0.70]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        [commentTitleLabel, commentTextField, locationTitleLabel, locationTextField, deleteBtn, deleteLineLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        commentTitleLabelBottomAnchor = commentTitleLabel.bottomAnchor.constraint(equalTo: commentTextField.topAnchor, constant: 0)
        locationTitleLabelBottomAnchor = locationTitleLabel.bottomAnchor.constraint(equalTo: locationTextField.topAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            // Comment
            commentTitleLabelBottomAnchor,
            commentTitleLabel.leadingAnchor.constraint(equalTo: commentTextField.leadingAnchor),
            commentTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            commentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            commentTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            commentTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            
            // Location
            locationTitleLabelBottomAnchor,
            locationTitleLabel.leadingAnchor.constraint(equalTo: locationTextField.leadingAnchor),
            locationTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            locationTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            locationTextField.topAnchor.constraint(equalTo: commentTextField.bottomAnchor, constant: 40),
            locationTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            
            
            // Delete
            deleteLineLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
            deleteLineLabel.heightAnchor.constraint(equalToConstant: 40),
            deleteLineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            deleteLineLabel.topAnchor.constraint(equalTo: commentTextField.bottomAnchor, constant: 120),
            
            deleteBtn.centerXAnchor.constraint(equalTo: deleteLineLabel.centerXAnchor, constant: 0),
            deleteBtn.centerYAnchor.constraint(equalTo: deleteLineLabel.centerYAnchor, constant: 0),
        ])
        view.bringSubviewToFront(deleteBtn)
    }
    
    
    // MARK: - Selectors
    @objc private func handleCancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleSaveBtn(_ sender: UIButton) {
        guard let navi = self.presentingViewController as? UINavigationController else { return }
        navi.viewControllers.forEach {
            guard let vc = $0 as? DetailViewController else { return }
            vc.commentLabel.text = self.commentTextField.text
            vc.locationLabel.text = self.locationTextField.text
            if commentTextField.text?.isEmpty == true {
                vc.commentLabelPlaceholder.alpha = 1
            }
            else {
                vc.commentLabelPlaceholder.alpha = 0
            }
            if locationTextField.text?.isEmpty == true {
                vc.locationLabelPlaceholder.alpha = 1
            }
            else {
                vc.locationLabelPlaceholder.alpha = 0
            }
        }
        album[selectedIndexPath.item].comment = commentTextField.text
        album[selectedIndexPath.item].imageTag = locationTextField.text
        persistenceManager.updateData(index: selectedIndexPath.item, textField: commentTextField, location: locationTextField)
        dismiss(animated: true)
    }
    
    @objc private func handleDeleteBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "이미지 삭제", message: "이미지를 정말 삭제하겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(
            title: "삭제",
            style: .destructive,
            handler: { _ in
                self.persistenceManager.deleteData(index: self.selectedIndexPath.item)
                album.remove(at: self.selectedIndexPath.item)
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        })
        [cancelAction, confirmAction].forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
}


// MARK: - UITextFieldDelegate
extension EditingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if commentTextField.text?.isEmpty == true {
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    self.commentTitleLabelBottomAnchor.constant = 20
                    self.commentTitleLabel.alpha = 0
                    self.view.layoutIfNeeded()
            })
        }
        else {
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    self.commentTitleLabelBottomAnchor.constant = 0
                    self.commentTitleLabel.alpha = 1
                    self.view.layoutIfNeeded()
            })
        }
        
        if locationTextField.text?.isEmpty == true {
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    self.locationTitleLabelBottomAnchor.constant = 20
                    self.locationTitleLabel.alpha = 0
                    self.view.layoutIfNeeded()
            })
        }
        else {
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    self.locationTitleLabelBottomAnchor.constant = 0
                    self.locationTitleLabel.alpha = 1
                    self.view.layoutIfNeeded()
            })
        }
    }
}
