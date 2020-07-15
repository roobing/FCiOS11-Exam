//
//  ViewController.swift
//  MovieTheater
//
//  Created by 박종덕 on 2020/06/03.
//  Copyright © 2020 example. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
  let label_filter = UILabel()
  let movieTable = UITableView()
  
  
  struct Size {
    static let cellHeight: CGFloat = 120
    static let posterHeight: CGFloat = 100
    static let filterHeight: CGFloat = 200
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setNavigation()

    //frame, background, font
    setLayout()
    setConstraints()
    setupTable(movieTable: movieTable)
    
//    setUI()
  }
  
  private func setNavigation() {
    navigationItem.title = "영화 차트"
  }

  func setLayout() {
    /*
     view.safeAreaLayoutGuide.layoutFrame
     view.frame
     
     view.safeAreaInsets
     */
    
    movieTable.rowHeight = Size.cellHeight
    
    
    label_filter.frame = CGRect(x: 0, y: 0, width: 0, height: Size.filterHeight)
    label_filter.backgroundColor = .lightGray
    label_filter.textColor = .darkGray
    label_filter.text = "∙예매율 순"
    label_filter.textAlignment = .left
    label_filter.font = .systemFont(ofSize: 13)
    
    view.addSubview(label_filter)
    view.addSubview(movieTable)
  }
  
  func setConstraints() {
    label_filter.translatesAutoresizingMaskIntoConstraints = false
    movieTable.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      label_filter.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      label_filter.bottomAnchor.constraint(equalTo: movieTable.topAnchor, constant: 0),
      label_filter.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
      label_filter.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
      
//      movieTable.topAnchor.constraint(equalTo: label_filter.bottomAnchor, constant: 10),
      movieTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      movieTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
      movieTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
      
      label_filter.heightAnchor.constraint(equalTo: movieTable.heightAnchor, multiplier: 0.05)
    ])
  }
  
  func setupTable(movieTable: UITableView) {
    movieTable.delegate = self
    movieTable.dataSource = self
    movieTable.register(MovieListCell.self, forCellReuseIdentifier: "MovieListCell")
    view.addSubview(movieTable)
  }
  
  
  //  private func setUI() {
  //    let imageView = UIImageView()
  //    imageView.frame = CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: 200))
  //    imageView.image = UIImage(named: "logo")
  //    imageView.contentMode = .scaleAspectFit
  //    tableView.tableHeaderView = imageView1
  //    tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
  //  }
}





extension MovieViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let movieListCell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
    let movie = movieList[indexPath.row]
    
    movieListCell.img_poster.image = UIImage(named: movie.poster)
    
    movieListCell.label_title.text = "\(movie.title)"
    movieListCell.label_genre.text = "\(movie.genre)"
    movieListCell.label_runningTime.text = "\(movie.runningTime)"
    movieListCell.label_releaseDate.text = "\(movie.releaseDate)"
    
    movieListCell.label_title.font = .boldSystemFont(ofSize: 16)
    movieListCell.label_genre.font = .systemFont(ofSize: 12)
    movieListCell.label_runningTime.font = .systemFont(ofSize: 12)
    movieListCell.label_releaseDate.font = .systemFont(ofSize: 12)

    movieListCell.img_poster.frame = CGRect(
      x: 10,
      y: 10,
      width: 70,
      height: Size.posterHeight
    )

    movieListCell.label_title.frame = CGRect(
      x: 100,
      y: 10,
      width: 250,
      height: 20
    )
    
    movieListCell.label_genre.frame = CGRect(
      x: 100,
      y: 40,
      width: 100,
      height: 20
    )
    
    movieListCell.label_runningTime.frame = CGRect(
      x: 200,
      y: 40,
      width: 100,
      height: 20
    )
    
    movieListCell.label_releaseDate.frame = CGRect(
      x: 100,
      y: 60,
      width: 100,
      height: 20
    )
    
    return movieListCell
  }
  
}


extension MovieViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailVC = DetailViewController()
    detailVC.movie = movieList[indexPath.row]
    detailVC.view.backgroundColor = .systemBackground
    navigationController?.pushViewController(detailVC, animated: true)
  }
}
