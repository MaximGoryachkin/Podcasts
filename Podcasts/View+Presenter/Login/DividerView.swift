//
//  DividerView.swift
//  Podcasts
//
//  Created by Ольга Шовгенева on 14.10.2023.
//

import UIKit

class DividerView: UIView {

    // MARK: - Private Properties
    private lazy var mainLabel: UILabel = {
        var label = UILabel()
        label.text = "Or continue with"
        label.textColor = UIColor(named: "dividerColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var leftView: UIView = {
        var leftView = UIView()
        leftView.backgroundColor = UIColor(named: "dividerColor")
        leftView.translatesAutoresizingMaskIntoConstraints = false
        return leftView
    }()
    
    private lazy var rightView: UIView = {
        var leftView = UIView()
        leftView.backgroundColor = UIColor(named: "dividerColor")
        leftView.translatesAutoresizingMaskIntoConstraints = false
        return leftView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addViews() {
        self.addSubview(mainLabel)
        self.addSubview(leftView)
        self.addSubview(rightView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            leftView.trailingAnchor.constraint(equalTo: mainLabel.leadingAnchor, constant: -10),
            leftView.heightAnchor.constraint(equalToConstant: 1),
            leftView.widthAnchor.constraint(equalToConstant: 62),
            leftView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            rightView.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 10),
            rightView.heightAnchor.constraint(equalToConstant: 1),
            rightView.widthAnchor.constraint(equalToConstant: 62),
            rightView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
