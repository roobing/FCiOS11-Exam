//
//  WriteReviewViewController.swift
//  1st-hackathon-movie
//
//  Created by Woobin Cheon on 2020/06/04.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import MobileCoreServices
import UIKit

class WriteReviewViewController: UIViewController {
    
    let containerView: UIView = UIView()
    let pictureView: UIImageView = UIImageView()
    let userNameLabel: UILabel = UILabel()
    let userNameTextField: UITextField = UITextField()
    let rateTextField: UITextField = UITextField()
    let reviewTitleTextFiled: UITextField = UITextField()
    let rateLabel: UILabel = UILabel()
    let reviewTextView: UITextView = UITextView()
    let photoLabel: UILabel = UILabel()
    
    let movie1: UIButton = UIButton()
    let movie2: UIButton = UIButton()
    let movie3: UIButton = UIButton()
    
    
    var rateNum: String = ""
    var reviewTitle: String = ""
    var reviewContents: String = ""
    var userName: String = ""
    var movieImage: UIImage = UIImage()
    
    private lazy var imagePicker : UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    let writeButton: UIButton = UIButton()
    
    struct containerValues {
        static let width: CGFloat = 300
        static let height: CGFloat = 450
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImage = UIImageView(image: UIImage(named: "back-lala"))
        backImage.frame = view.frame
        view.addSubview(backImage)
        
        setUI()
        setMovieSelectUI()
        setNavigation()
        
    }
    
    func setNavigation() {
        navigationItem.title = "후기작성"
        let cameraButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(runCamera(_:)))
        let albumButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.2.square.stack"), style: .plain, target: self, action: #selector(runAlbum(_:)))
        navigationItem.rightBarButtonItems = [cameraButton, albumButton]
    }
    
    func setMovieSelectUI() {
        movie1.frame.origin = CGPoint(x: view.center.x - containerValues.width / 2 + 10, y: 95)
        movie1.frame.size = CGSize(width: 80, height: 80)
        movie1.setImage(UIImage(named: "침입자_포스터"), for: .normal)
        movie1.setImage(UIImage(named: "침입자_포스터-복사본"), for: .selected)
        movie1.isSelected = false
        movie1.addTarget(self, action: #selector(check(_:)), for: .touchUpInside)
        movie1.setTitle(movieList[0].title, for: .normal)
        movie1.clipsToBounds = true
        movie1.layer.cornerRadius = 10
        view.addSubview(movie1)
        
        movie2.frame.origin = CGPoint(x: view.center.x - containerValues.width / 2 + 110, y: 95)
        movie2.frame.size = CGSize(width: 80, height: 80)
        movie2.setImage(UIImage(named: "매드맥스_분노의 도로_포스터"), for: .normal)
        movie2.setImage(UIImage(named: "매드맥스_분노의 도로_포스터-복사본"), for: .selected)
        movie2.isSelected = false
        movie2.addTarget(self, action: #selector(check(_:)), for: .touchUpInside)
        movie2.setTitle(movieList[1].title, for: .normal)
        movie2.clipsToBounds = true
        movie2.layer.cornerRadius = 10
        view.addSubview(movie2)
        
        movie3.frame.origin = CGPoint(x: view.center.x - containerValues.width / 2 + 210, y: 95)
        movie3.frame.size = CGSize(width: 80 , height: 80)
        movie3.setImage(UIImage(named: "위대한 쇼맨_포스터"), for: .normal)
        movie3.setImage(UIImage(named: "위대한 쇼맨_포스터-복사본"), for: .selected)
        movie3.isSelected = false
        movie3.addTarget(self, action: #selector(check(_:)), for: .touchUpInside)
        movie3.setTitle(movieList[2].title, for: .normal)
        movie3.clipsToBounds = true
        movie3.layer.cornerRadius = 10
        view.addSubview(movie3)
    }
    
    @objc func check(_ sender: UIButton) {
        movieImage = sender.currentImage!
        sender.isSelected = !sender.isSelected
    }
    
    func setUI() {
        
        containerView.frame.origin = CGPoint(x: view.center.x - containerValues.width / 2, y: 180)
        containerView.frame.size = CGSize(width: containerValues.width, height: containerValues.height)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0.8
        containerView.layer.cornerRadius = 20
        view.addSubview(containerView)
        
        pictureView.frame.origin = CGPoint(x: 10, y: 10)
        pictureView.frame.size = CGSize(width: 150, height: 150)
        pictureView.largeContentTitle = "인증샷"
        pictureView.backgroundColor = .systemYellow
        pictureView.layer.cornerRadius = 20
        containerView.addSubview(pictureView)
        
        photoLabel.frame = pictureView.frame
        photoLabel.text = "인증샷"
        photoLabel.textAlignment = .center
        
        pictureView.addSubview(photoLabel)
        
        userNameLabel.frame.origin = CGPoint(x: pictureView.frame.size.width + 20, y: 10)
        userNameLabel.frame.size = CGSize(width: 110, height: 30)
        userNameLabel.clipsToBounds = true
        userNameLabel.layer.cornerRadius = 5
        userNameLabel.text = "작성자"
        userNameLabel.textAlignment = .center
        containerView.addSubview(userNameLabel)
        
        userNameTextField.frame.origin = CGPoint(x: pictureView.frame.size.width + 20, y: 50)
        userNameTextField.frame.size = CGSize(width: 110, height: 30)
        userNameTextField.backgroundColor = .systemBackground
        userNameTextField.clipsToBounds = true
        userNameTextField.layer.cornerRadius = 5
        userNameTextField.placeholder = "이름"
        userNameTextField.textAlignment = .center
        userNameTextField.tag = 0
        userNameTextField.delegate = self
        containerView.addSubview(userNameTextField)
        
        rateLabel.frame.origin = CGPoint(x: pictureView.frame.size.width + 20, y: 90)
        rateLabel.frame.size = CGSize(width: 110, height: 30)
        rateLabel.clipsToBounds = true
        rateLabel.layer.cornerRadius = 5
        rateLabel.text = "평점"
        rateLabel.textAlignment = .center
        containerView.addSubview(rateLabel)
        
        rateTextField.frame.origin = CGPoint(x: pictureView.frame.size.width + 20, y: 130)
        rateTextField.frame.size = CGSize(width: 110, height: 30)
        rateTextField.backgroundColor = .systemBackground
        rateTextField.clipsToBounds = true
        rateTextField.layer.cornerRadius = 5
        rateTextField.placeholder = "평점입력"
        rateTextField.textAlignment = .center
        rateTextField.tag = 1
        rateTextField.delegate = self
        containerView.addSubview(rateTextField)
        
        reviewTitleTextFiled.frame.origin = CGPoint(x: 10, y: pictureView.frame.size.height + 20)
        reviewTitleTextFiled.frame.size = CGSize(width: 280, height: 40)
        reviewTitleTextFiled.backgroundColor = .systemGreen
        reviewTitleTextFiled.clipsToBounds = true
        reviewTitleTextFiled.layer.cornerRadius = 20
        reviewTitleTextFiled.placeholder = "후기제목"
        reviewTitleTextFiled.textAlignment = .center
        reviewTitleTextFiled.tag = 2
        reviewTitleTextFiled.delegate = self
        containerView.addSubview(reviewTitleTextFiled)
        
        reviewTextView.frame.origin = CGPoint(x: 10, y: pictureView.frame.size.height + 70)
        reviewTextView.frame.size = CGSize(width: 280, height: 220)
        reviewTextView.backgroundColor = .systemGray
        reviewTextView.layer.cornerRadius = 20
        reviewTextView.delegate = self
        containerView.addSubview(reviewTextView)
        
        writeButton.frame.origin = CGPoint(x: view.center.x - containerValues.width / 4, y: containerValues.height + 200)
        writeButton.frame.size = CGSize(width: containerValues.width / 2, height: containerValues.height / 7)
        writeButton.backgroundColor = .systemBlue
        writeButton.setTitle("올리기", for: .normal)
        writeButton.layer.cornerRadius = 20
        writeButton.addTarget(self, action: #selector(saveReview(_:)), for: .touchUpInside)
        view.addSubview(writeButton)
        
    }
    
    @objc func saveReview(_ sender: UIButton) {
        
        print("saveReview1: \(reviewContents)")
        let tempReview = ReviewData(rate: rateNum, image: pictureView.image, userName: userName, title: reviewTitle, contents: reviewContents, movieImage: movieImage)
        
        ReviewInfo.shared.reviewInfo.append(tempReview)
        print("saveReview2: \(ReviewInfo.shared.reviewInfo[0].contents!)")
        navigationController?.popViewController(animated: true)
    }
}

extension WriteReviewViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
        textField.becomeFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        switch textField.tag {
        case 0:
            userName = textField.text ?? "홍길동"
        case 1:
            rateNum = textField.text ?? "0"
        case 2:
            reviewTitle = textField.text ?? "제목 없음"
        default:
            break
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        switch textField.tag {
        case 0:
            userName = textField.text ?? "홍길동"
        case 1:
            rateNum = textField.text ?? "0"
        case 2:
            reviewTitle = textField.text ?? "제목 없음"
        default:
            break
        }
        textField.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.becomeFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("textViewDidChange")
        reviewContents = textView.text
        print(reviewContents)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing")
        textView.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension WriteReviewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func runCamera(_ sender: UIBarButtonItem) {
        print("\n---------- [ takePicture ] ----------\n")
        
        // 카메라 사용 할 수 있는지 체크
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        imagePicker.sourceType = .camera
        
//        print(imagePicker.mediaTypes) // ["public.image"]
        let mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)
//        print(mediaTypes) // Optional(["public.image", "public.movie"])
        
        imagePicker.mediaTypes = mediaTypes ?? []
        imagePicker.mediaTypes = ["public.image", "public.movie"]
        
        
        // import MobileCoreServices
        // kUTTypeVideo - 영상
        // kUTTypeMovie - 영상 + 소리 => 마이크로폰 권한이 필요함
        imagePicker.mediaTypes = [kUTTypeImage, kUTTypeMovie] as [String]
        
        if UIImagePickerController.isFlashAvailable(for: .rear) {
            imagePicker.cameraFlashMode = .auto
        }
        present(imagePicker, animated: true)
    }
        @objc func runAlbum(_ sender: Any) {
            print("\n---------- [ pickImage ] ----------\n")
            
            imagePicker.sourceType = .savedPhotosAlbum
    //        imagePicker.sourceType = .photoLibrary // Default
            
            /*
             photoLibrary - 앨범을 선택하는 화면을 표시 후, 선택한 앨범에서 사진 선택
             camera - 새로운 사진 촬영
             savedPhotosAlbum - 최근에 찍은 사진들을 나열
             */
            
            imagePicker.mediaTypes = [kUTTypeImage, kUTTypeMovie] as [String]
            
            present(imagePicker, animated: true)
        }
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let mediaType = info[.mediaType] as! NSString
            
            if UTTypeEqual(mediaType, kUTTypeImage) {
                let originalImage = info[.originalImage] as! UIImage
                let editedImage = info[.editedImage] as? UIImage
                let selectedImage = editedImage ?? originalImage
                pictureView.image = selectedImage
            }
            photoLabel.isHidden = true
            
    //        self.dismiss(animated: true, completion: nil)
            picker.presentingViewController?.dismiss(animated: true, completion: nil)
        }
}
