//
//  SearchViewController.swift
//  Podcasts
//
//  Created by Miras Maratov on 28.09.2023.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    private let searchBar: UISearchBar = {
        let element = UISearchBar()
        element.placeholder = "Podcast, chanel or artist"
        //element.showsScopeBar = true
        element.backgroundImage = UIImage()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
        searchBar.delegate = self
        view.addSubview(searchBar)
        setConstraints()
    }
    
    // Метод делегата для обработки события начала ввода текста в поисковую строку
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // Действия, выполняемые при начале ввода текста
    }
    
    // Метод делегата для обработки события нажатия кнопки "Поиск" на клавиатуре
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Действия, выполняемые при нажатии кнопки "Поиск"
    }
    
    // Метод делегата для обработки события нажатия кнопки "Отмена"
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Действия, выполняемые при нажатии кнопки "Отмена"
        searchBar.resignFirstResponder() // Скрываем клавиатуру
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 113),
            searchBar.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
