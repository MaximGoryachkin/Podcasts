//
//  ViewController.swift
//  CVC
//
//  Created by Леонид Турко on 05.10.2023.
//

import UIKit
import SwiftUI

class CreateViewController: UIViewController {
  
  private lazy var mainView: UIView = {
    let element = UIView()
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var searchBarView: UIView = {
    let element = UIView()
    element.layer.cornerRadius = 12
    element.clipsToBounds = true
    element.layer.borderColor = UIColor.gray.cgColor
    element.layer.borderWidth = 1
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private let makeSearchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.placeholder = "Search"
    searchBar.barTintColor = #colorLiteral(red: 0.9215686275, green: 0.9333333333, blue: 0.9803921569, alpha: 1)
    searchBar.layer.cornerRadius = 12
    searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9333333333, blue: 0.9803921569, alpha: 1)
    return searchBar
  }()
  
  private let lineView: UIView = {
    let view = UIView()
    view.backgroundColor = .gray
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let podcastImage: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.image = UIImage(systemName: "hand.thumbsup.fill")
    image.tintColor = .red
    image.backgroundColor = .green
    return image
  }()
  
  private let podcastTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Give a name for your playlist"
    textField.textAlignment = .center
    return textField
  }()
  
  private let collectionView: UICollectionView  = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout
    )
    collectionView.register(TableCell.self, forCellWithReuseIdentifier: TableCell.reuseIdentifier)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  let podcasts = PodcastList()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationItem()
    setViews()
    setConstraints()
    setDelegates()
  }
  
//  override func viewWillAppear(_ animated: Bool) {
//    setupNavigationItem()
//  }
  
  private func setupNavigationItem() {
    let rightItem = UIBarButtonItem()
    let leftItem = UIBarButtonItem()
    rightItem.image = UIImage(named: "dots")
    leftItem.image = UIImage(systemName: "arrow.left")
    rightItem.tintColor = .lightGray
    leftItem.tintColor = .lightGray
    navigationItem.title = "Create Playlist"
    navigationItem.rightBarButtonItems = [rightItem]
    navigationItem.leftBarButtonItems = [leftItem]
  }
  
  private func setDelegates() {
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  private func setViews() {
    view.backgroundColor = .white
    
    view.addSubview(mainView)
    view.addSubview(makeSearchBar)
    view.addSubview(collectionView)
    view.addSubview(searchBarView)
    searchBarView.addSubview(makeSearchBar)
    mainView.addSubview(podcastImage)
    mainView.addSubview(podcastTextField)
    mainView.addSubview(lineView)
  }
  
  private func setConstraints() {
    NSLayoutConstraint.activate([
      mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      mainView.heightAnchor.constraint(equalToConstant: 250),
      mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      
      podcastImage.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
      podcastImage.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
      podcastImage.widthAnchor.constraint(equalToConstant: 84),
      podcastImage.heightAnchor.constraint(equalTo: podcastImage.widthAnchor),
      
      podcastTextField.topAnchor.constraint(equalTo: podcastImage.bottomAnchor,constant: 30),
      podcastTextField.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
      
      lineView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
      //lineView.bottomAnchor.constraint(equalTo: podcastTextField.bottomAnchor, constant: 20),
      lineView.heightAnchor.constraint(equalToConstant: 2),
      lineView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
      lineView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
      
      searchBarView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 25),
      searchBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      searchBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      
      makeSearchBar.leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor),
      makeSearchBar.trailingAnchor.constraint(equalTo: searchBarView.trailingAnchor),
      makeSearchBar.topAnchor.constraint(equalTo: searchBarView.topAnchor),
      makeSearchBar.bottomAnchor.constraint(equalTo: searchBarView.bottomAnchor),
      
      collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
      collectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 25)
    ])
  }
}

extension CreateViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    podcasts.all.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCell.reuseIdentifier, for: indexPath) as? TableCell else { return UICollectionViewCell() }
    let podcast = podcasts.all[indexPath.item]
    cell.configure(with: podcast)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = CGFloat(collectionView.frame.width)
    let cellHeight = CGFloat(100)
    return CGSize(width: cellWidth, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 20
  }
}

struct ContentViewController: UIViewControllerRepresentable {
  
  typealias UIViewControllerType = CreateViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    return CreateViewController()
  }
  
  func updateUIViewController(_ uiViewController: CreateViewController, context: Context) {}
}

struct ContentViewController_Previews: PreviewProvider {
  static var previews: some View {
    ContentViewController()
      .edgesIgnoringSafeArea(.all)
      .colorScheme(.light) // or .dark
  }
}
