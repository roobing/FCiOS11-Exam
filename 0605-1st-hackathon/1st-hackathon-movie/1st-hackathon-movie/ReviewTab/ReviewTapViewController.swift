//
//  ReviewTapViewController.swift
//  1st-hackathon-movie
//
//  Created by Woobin Cheon on 2020/06/03.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class ReviewTapViewController: UITableViewController {

    let writeReviewList: UITableView = UITableView()
    lazy var writeReview: UIBarButtonItem = UIBarButtonItem(title: "관람인증하기", style: .plain, target: self, action: #selector(goToWrite))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setNavigationTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func setUI() {
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reviewListCellID")
        tableView.register(ReviewListTableViewCell.self, forCellReuseIdentifier: ReviewListTableViewCell.reivewListCellID)
    }
    
    func setNavigationTitle() {
        navigationItem.title = "인증게시판"
        navigationItem.rightBarButtonItem = writeReview
    }
    
    @objc func goToWrite() {
        let writeVC = WriteReviewViewController()
        navigationController?.pushViewController(writeVC, animated: true)
    }
}

extension ReviewTapViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        ReviewInfo.shared.reviewIndex
        ReviewInfo.shared.reviewInfo.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewListTableViewCell.reivewListCellID, for: indexPath) as? ReviewListTableViewCell else { return fatalError() as! UITableViewCell }
        cell.reviewTitleLabel.text = "제목: \(ReviewInfo.shared.reviewInfo[indexPath.row].title ?? "")"
        cell.reviewListImage.image = ReviewInfo.shared.reviewInfo[indexPath.row].image
        cell.reviewRateLabel.text = "평점: \(ReviewInfo.shared.reviewInfo[indexPath.row].rate ?? "")"
        cell.reviewUserNameLabel.text = "작성자: \(ReviewInfo.shared.reviewInfo[indexPath.row].userName ?? "")"
        cell.reviewMovieImage.image = ReviewInfo.shared.reviewInfo[indexPath.row].movieImage
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reviewListCellID")
//        cell.textLabel?.text = "후기: \(ReviewInfo.shared.reviewInfo[indexPath.row].contents ?? "")"
//        cell.detailTextLabel?.text = "평점: \(ReviewInfo.shared.reviewInfo[indexPath.row].rate ?? 0)"
//        cell.imageView?.image = ReviewInfo.shared.reviewInfo[indexPath.row].image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let readReviewVC = ReadReviewViewController()
        readReviewVC.reviewIndex = indexPath.row
        navigationController?.pushViewController(readReviewVC, animated: true)
    }
}
