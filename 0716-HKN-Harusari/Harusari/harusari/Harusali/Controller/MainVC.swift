//
//  MainVC.swift
//  Harusali
//
//  Created by 김믿음 on 2020/07/14.
//  Copyright © 2020 김믿음. All rights reserved.
//
// 안녕

import UIKit
import Firebase
//import Lottie

class MainVC: UIViewController {
    
    let firestore = Firestore.firestore()
    // MARK: Properties
    let backgroundImage: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "whiteBackground")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let accountVC = AccountVC()
    
    let signinVC2 = SignInVC2()
    lazy var navController = UINavigationController(rootViewController: self.signinVC2)
    
//    let signinVC1 = SignInVC1()
//    lazy var navController1 = UINavigationController(rootViewController: self.signinVC1)
    
    var shareImage: UIImage?
    
    var selectMoney = UserDefaults.standard.string(forKey: UserReference.balance) ?? ""
    
    var buttonToggle = false
    
    var centerXChangeTimer = Timer()
    var labeltextChangeTimer = Timer()
    
    var aniDuration: Double = 1
    
    var labelTimerInterval = 0.01
    
    var moneyList = ["10000", "20000", "30000", "40000", "50000"]
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "금액 추첨"
        label.font = UIFont(name: "BMEULJIRO", size: 60)
        label.textColor = UIColor(rgb: 0x017831)
        return label
    }()
    
    var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BMEULJIRO", size: 60)
        label.text = ""
        return label
    }()
    
    var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.tintColor = UIColor(rgb: 0x017831)
        button.titleLabel!.font = UIFont(name: "BMEULJIRO", size: 40)
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        return button
    }()
    
//    let nextButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("다음", for: .normal)
//        button.titleLabel!.font = UIFont(name: "BMEULJIRO", size: 40)
//        button.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
//        return button
//    }()
    
//    lazy var animationView : AnimationView = {
//        let animationView = AnimationView(name: "lf30_editor_alHpIE")
//        animationView.frame = self.view.frame
//        animationView.backgroundColor = .white
//        animationView.contentMode = .scaleAspectFit
//        animationView.loopMode = .playOnce
//        animationView.animationSpeed = 0.5
//        return animationView
//    }()
    
    var time: Int = 0 {
        didSet {
            labeltextChangeTimer.invalidate()
            startLabelTextChangeTimer()
            guard self.aniDuration < 6 else {
                UserDefaults.standard.set(true, forKey: UserReference.checkSetBalance)
                print("금액추첨후 현재 checkSetBalance\(UserDefaults.standard.bool(forKey: UserReference.checkSetBalance))")
                self.selectMoney = self.moneyLabel.text!
                UIView.animateKeyframes(
                    withDuration: self.aniDuration,
                    delay: 0,
                    animations: {
                        UIView.addKeyframe(
                            withRelativeStartTime: 0,
                            relativeDuration: 0.03
                        ){
                            UIView.animate(withDuration: 1, delay: 0.7, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                                self.moneyLabel.center.x = self.view.center.x
                            }, completion: nil)
                        }
                })
                centerXChangeTimer.invalidate()
                labeltextChangeTimer.invalidate()
                if let useruid = Auth.auth().currentUser?.uid {
                    self.firestore.collection("User").document(useruid).updateData([UserReference.balance: self.selectMoney])
                    
//                    self.firestore.collection("User").document(useruid).getDocument { (snapshot, error) in
//                        if let error = error {
//                            print(error.localizedDescription)
//                        }
//
//                        if let data = snapshot {
//                            guard
//                                let data = snapshot?.data(),
//                                let email = data[UserReference.email] as? String,
//                                let name = data[UserReference.name] as? String,
//                                let balance = data[UserReference.balance] as? String
//
//                                //                                let checkSetBalance = data[UserReference.checkSetBalance] as? Bool
//                                else {return}
//                        }
//                    }
                }
                
                UserDefaults.standard.set(self.selectMoney, forKey: UserReference.balance)
                print("추첨된 금액은\(self.selectMoney)원 입니다.")
                guard let userName = UserDefaults.standard.string(forKey: UserReference.name) else {return}
                guard let selectMoney = UserDefaults.standard.string(forKey: UserReference.balance) else {return}
                let alert = UIAlertController(
                    title: "알림",
                    message:
                    """
                    오늘 \(userName)님의
                    도전금액은 \(selectMoney)원 입니다.
                    친구들에게 공유해주세요!!
                    """,
                    preferredStyle: .alert)
                let ok = UIAlertAction(title: "공유하기", style: .default) { (presentActivity) in
                    self.showActivity()
                }
                let cancel = UIAlertAction(title: "공유 안하기", style: .cancel) { (presentAccountView) in
//                    self.navigationController?.pushViewController(self.accountVC, animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    print("y값 변경 시작")
                    UIView.animate(withDuration: 2) {
                        self.moneyLabel.center.y -= 150
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                        self.present(alert, animated: true)
                    }
                }
                alert.addAction(ok)
                alert.addAction(cancel)
                return
            }
            UIView.animateKeyframes(
                withDuration: self.aniDuration,
                delay: 0,
                animations: {
                    UIView.addKeyframe(
                        withRelativeStartTime: 0,
                        relativeDuration: 0.03
                    ){
                        self.moneyLabel.center.x -= 600
                    }
                    self.moneyLabel.center.x = self.view.center.x + 300
            })
            self.aniDuration += 1
            self.labelTimerInterval += 0.1
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
            super.viewDidLoad()
            configureViewComponents()
        
//            checkIfUserLoggedIn()
            
        self.navigationController?.navigationBar.isHidden = true
//            animationView.play{ (finish) in
//                self.animationView.removeFromSuperview()
//            }
    }
    
    
    // MARK: @objc
    @objc func didTapStartButton() {
        if buttonToggle == false {
            print("start animation")
            UIView.animate(withDuration: 2, animations: {
                self.startButton.alpha = 0
            }) { (after) in
                UIView.animate(withDuration: 2, delay: 7, animations: {
                    self.startButton.setTitle("다음", for: .normal)
                    self.startButton.alpha = 1
                }, completion: nil)
            }
            startCenterXChangeTimer()
        }else {
            self.dismiss(animated: true, completion: nil)
        }
        buttonToggle.toggle()
    }
    
    @objc func updateTime() {
        self.time += 1
        print(self.time)
    }
    
    @objc func updateLabelText() {
        self.moneyLabel.text = self.moneyList.randomElement()
    }
    
    @objc func didTapLogout() {
//        try? Auth.auth().signOut()
//        UserDefaults.standard.set("", forKey: UserReference.name)
//        UserDefaults.standard.set("", forKey: UserReference.balance)
//        UserDefaults.standard.set("", forKey: UserReference.email)
//        print("logout")
//        navController.title = "Login"
//        navController.navigationBar.prefersLargeTitles = true
//        navController.modalPresentationStyle = .fullScreen
//        present(navController, animated: true)
    }
    
    // MARK: Timer
    func startLabelTextChangeTimer() {
        labeltextChangeTimer = Timer.scheduledTimer(timeInterval: labelTimerInterval, target: self, selector: #selector(updateLabelText), userInfo: nil, repeats: true)
    }
    
    func startCenterXChangeTimer() {
        centerXChangeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    // MARK: Show UIActivityViewContoller
    func showActivity() {
        guard let userName = UserDefaults.standard.string(forKey: UserReference.name) else {return}
        guard let selectMoney = UserDefaults.standard.string(forKey: UserReference.balance) else {return}
        let shareText: String =
        """
        From. HaruSari
        \(userName)님의 하루살이가 시작되었습니다.
        도전금액은 \(selectMoney)원!
        하루 살이
        AppStore 다운로드
        htps://apps.apple.com/us/app/keynote/id409183694?mt=12
        """
        switch selectMoney {
        case "10000":
            shareImage = UIImage(named: "10000원")
        case "20000":
            shareImage = UIImage(named: "20000원")
        case "30000":
            shareImage = UIImage(named: "30000원")
        case "40000":
            shareImage = UIImage(named: "40000원")
        case "50000":
            shareImage = UIImage(named: "50000원")
        default:
            print("default")
        }
        
        var shareObject = [Any]()
        
        shareObject.append(shareImage!)
        shareObject.append(shareText)
        
        let activityViewController = UIActivityViewController(activityItems : shareObject, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        //activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.mail]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    // MARK: ConfigureViewComponents
    private func configureViewComponents() {
        view.backgroundColor = .white
        
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
//        view.addSubview(nextButton)
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        view.addSubview(moneyLabel)
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        moneyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        moneyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 300).isActive = true
        
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
//        view.addSubview(animationView)
//        animationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        animationView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        animationView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: CheckCurrentUser And PresntViewController
//    func checkIfUserLoggedIn() {
//        if Auth.auth().currentUser == nil {
//            print("-- SigninVC1 Did Load (Current Login State Is Logout State) --")
//            DispatchQueue.main.async {
//                self.navController1.modalPresentationStyle = .fullScreen
//                self.present(self.navController1, animated: false)
//            }
//            return
//        } else {
//            print("-- SigninVC2 Did Load   (Current Login State Is Login State) --")
//        }
//    }
}
