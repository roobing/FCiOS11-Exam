//
//  Intro.swift
//  Harusali
//
//  Created by 김동현 on 2020/07/21.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    
    
    
    
    
    
    let imgView1: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "intro4")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
     let titleLabel1: UILabel = {
        let label = UILabel()
        label.text = "하루살이를 위한 금액추첨"
        label.numberOfLines = 0
        label.font = UIFont(name: "BMEULJIRO", size: 34)
         return label
     }()
    
    let bodyLabel1: UILabel = {
       let label = UILabel()
        label.text = """
        10,000원에서 50,000원까지
        하루살이를 위해 금액을 추첨해주세요!
        하루동안 정해진 금액으로 소비욕구 강제 근절!😜
        카카오톡으로 공유하고 친구와 함께 할수 있어요!
        """
        
        
        label.numberOfLines = 0
        label.font = UIFont(name: "BMEULJIRO", size: 17)
        return label
    }()
    
    
    
    let imgView2: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "intro2")
        iv.alpha = 0
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
     let titleLabel2: UILabel = {
        let label = UILabel()
        label.text = "지출내역 상세관리"
        label.numberOfLines = 0
        label.alpha = 0
        label.font = UIFont(name: "BMEULJIRO", size: 34)
         return label
     }()
    
    let bodyLabel2: UILabel = {
       let label = UILabel()
        label.alpha = 0
        label.text = """
        상세관리에서 남은 금액을 확인하고,
        날짜별 지출내역을 확인할수 있어요!
        카테고리와 금액을 직관적으로 볼수 있어
        효율적이고 알뜰하게
        지출계획을 세울수 있어요🤓
        """
        label.numberOfLines = 0
        label.font = UIFont(name: "BMEULJIRO", size: 17)
        return label
    }()
    
    
    
    let imgView3: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "intro3")
        iv.alpha = 0
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
     let titleLabel3: UILabel = {
        let label = UILabel()
        label.text = "지출 내역 추가"
        label.numberOfLines = 0
        label.alpha = 0
        label.font = UIFont(name: "BMEULJIRO", size: 34)
         return label
     }()
    
    let bodyLabel3: UILabel = {
       let label = UILabel()
        label.alpha = 0
        label.text = """
        오늘 지출한 내역을 금액과 카테고리를 적어주고,
        상세 내용은 내역 부분에 적어주세요!
        남은 금액 이상으로 금액을 입력하면 내역추가가 안되니
        이점 주의해서 지출계획을 세워주세요🤩
        이제 하루살이 시작하러 Go!
        """
        label.numberOfLines = 0
        label.font = UIFont(name: "BMEULJIRO", size: 17)
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupimgView1()
        setupStackView1()
        
        setupimgView2()
        setupStackView2()
        
        setupimgView3()
        setupStackView3()
        // ani
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapAni)))
    }
    
    @objc func handleTapAni() {
        if self.imgView1.alpha == 1 {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.imgView1.transform = CGAffineTransform(translationX: -30, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.imgView1.alpha = 0
                    self.imgView1.transform = self.titleLabel1.transform.translatedBy(x: 0, y: -500)
                }, completion: nil)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.titleLabel1.transform = CGAffineTransform(translationX: -30, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.titleLabel1.alpha = 0
                    self.titleLabel1.transform = self.titleLabel1.transform.translatedBy(x: 0, y: -200)
                }, completion: nil)
            }
            
            UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.bodyLabel1.transform = CGAffineTransform(translationX: -30, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.bodyLabel1.alpha = 0
                    self.bodyLabel1.transform = self.bodyLabel1.transform.translatedBy(x: 0, y: -200)
                }) { (_) in
                    UIView.animate(withDuration: 1) {
                        self.imgView2.alpha = 1
                        self.titleLabel2.alpha = 1
                        self.bodyLabel2.alpha = 1
                    }
                }
            }
        }
        
        if self.imgView2.alpha == 1 {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.imgView2.transform = CGAffineTransform(translationX: -30, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.imgView2.alpha = 0
                    self.imgView2.transform = self.titleLabel2.transform.translatedBy(x: 0, y: 500)
                }, completion: nil)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.bodyLabel2.transform = CGAffineTransform(translationX: -30, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.bodyLabel2.alpha = 0
                    self.bodyLabel2.transform = self.bodyLabel2.transform.translatedBy(x: 0, y: 500)
                }, completion: nil)
            }
            
            UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.titleLabel2.transform = CGAffineTransform(translationX: -30, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.titleLabel2.alpha = 0
                    self.titleLabel2.transform = self.titleLabel2.transform.translatedBy(x: 0, y: 500)
                }) { (_) in
                    UIView.animate(withDuration: 1) {
                        self.imgView3.alpha = 1
                        self.titleLabel3.alpha = 1
                        self.bodyLabel3.alpha = 1
                    }
                }
            }
        }
        
        if self.imgView3.alpha == 1 {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.imgView3.transform = CGAffineTransform(translationX: -30, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.imgView3.alpha = 0
                    self.imgView3.transform = self.titleLabel3.transform.translatedBy(x: 300, y: 0)
                }, completion: nil)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.titleLabel3.transform = CGAffineTransform(translationX: -30, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.titleLabel3.alpha = 0
                    self.titleLabel3.transform = self.titleLabel3.transform.translatedBy(x: -300, y: 0)
                }, completion: nil)
            }
            
            UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.bodyLabel3.transform = CGAffineTransform(translationX: -30, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.bodyLabel3.alpha = 0
                    self.bodyLabel3.transform = self.bodyLabel3.transform.translatedBy(x: 300, y: 0)
                }) { (_) in
                    UIView.animate(withDuration: 2) {
//                        self.navigationController?.pushViewController(MainVC(), animated: true)
                        if let vc = self.navigationController?.presentingViewController as? SignInVC1{
                            UIView.animate(withDuration: 2) {
                                vc.backgroundImage.alpha = 1
                                vc.titleLabel.alpha = 1
                                vc.idTextField.alpha = 1
                                vc.passWordTextField.alpha = 1
                                vc.loginBT.alpha = 1
                                vc.signupBT.alpha = 1
                            }
                            
                        }
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        
        
    }
    
    
    func setupimgView1() {
        view.addSubview(imgView1)
        imgView1.translatesAutoresizingMaskIntoConstraints = false
        imgView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        imgView1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView1.widthAnchor.constraint(equalToConstant: 170).isActive = true
        imgView1.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setupimgView2() {
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel2, bodyLabel2])
        stackView.axis = .vertical
        stackView.spacing = 8
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 160).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        
        view.addSubview(imgView2)
        imgView2.translatesAutoresizingMaskIntoConstraints = false
        imgView2.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 60).isActive = true
        imgView2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView2.widthAnchor.constraint(equalToConstant: 170).isActive = true
        imgView2.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        
    }
    
    func setupimgView3() {
        view.addSubview(imgView3)
        imgView3.translatesAutoresizingMaskIntoConstraints = false
        imgView3.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        imgView3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView3.widthAnchor.constraint(equalToConstant: 170).isActive = true
        imgView3.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setupStackView1() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel1, bodyLabel1])
        stackView.axis = .vertical
        stackView.spacing = 8
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: imgView1.bottomAnchor, constant: 50).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
    }
    
    func setupStackView2() {
        
        
    }
    
    func setupStackView3() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel3, bodyLabel3])
        stackView.axis = .vertical
        stackView.spacing = 8
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: imgView3.bottomAnchor, constant: 50).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
    }
    
    
}

