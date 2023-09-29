//
//  AccountViewController.swift
//  Podcasts
//
//  Created by Максим Горячкин on 28.09.2023.
//

import UIKit

class AccountViewController: UIViewController {
    
    private var contentSize : CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 560)
    }
    
    private lazy var scroolView: UIScrollView = {
        let view = UIScrollView()
        view.contentSize = contentSize
        view.frame = self.view.bounds
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var mainStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .top
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var firstLabel: UILabel = {
        let view = UILabel()
        view.text = "First Name"
        view.font = .manropeRegular14
        view.textColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var firstTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scroolView)
//        addSubviews(main: mainStack, views: firstLabel, firstTextField)
        setupUI()
    }
    
    private func addSubviews(views: UIView...) {
        for view in views {
            self.view.addSubview(view)
        }
    }
    
    private func addSubviews(main stack: UIStackView, views: UIView...) {
        for view in views {
            stack.addArrangedSubview(view)
        }
    }
    
    private func setupUI() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
}
