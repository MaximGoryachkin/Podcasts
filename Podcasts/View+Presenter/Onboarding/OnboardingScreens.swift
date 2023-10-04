//
//  OnboardingScreens.swift
//  Podcasts
//
//  Created by Alexander Altman on 27.09.2023.
//

import UIKit

final class OnboardingScreens: UIView {
    
    //MARK: - Elements
    private lazy var blueView: UIView = {
        let element = UIView()
        element.backgroundColor = .backBlue
        element.layer.cornerRadius = 30
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var circleImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "firstImage")
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .fillEqually
        element.alignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var pageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pageSubLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.layer.backgroundColor = UIColor.white.cgColor
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.layer.backgroundColor = .none
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.layer.backgroundColor = UIColor.deepBlue?.cgColor
        button.setTitle("Get Started", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(blueView)
        addSubview(circleImageView)
        blueView.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(pageLabel)
        labelsStackView.addArrangedSubview(pageSubLabel)
        blueView.addSubview(continueButton)
        blueView.addSubview(skipButton)
        blueView.addSubview(nextButton)
        setConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setFontSizes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    public func setPageLabelText(text: NSAttributedString, text2: NSAttributedString) {
        pageLabel.attributedText = text
        pageSubLabel.attributedText = text2
    }
    
    public func setTransformWith(transform: CGAffineTransform) {
        pageLabel.transform = transform
        pageSubLabel.transform = transform
        circleImageView.transform = transform
    }
    
    public func hideContinueButton() {
        continueButton.isHidden = true
    }
    
    public func hideSkipNextButtons() {
        skipButton.isHidden = true
        nextButton.isHidden = true
    }
    
    //MARK: - Private Methods
    private func setFontSizes() {
        let scaleFactor: CGFloat = bounds.width / 375.0 // Set the reference screen width
        
        let pageLabelFontSize: CGFloat = 24.0 * scaleFactor
        pageLabel.font = UIFont(name: Fonts.boldFont, size: pageLabelFontSize)
        pageLabel.adjustsFontSizeToFitWidth = true
        
        let pageSubLabelFontSize: CGFloat = 16.0 * scaleFactor
        pageSubLabel.font = UIFont(name: Fonts.regularFont, size: pageSubLabelFontSize)
        pageSubLabel.adjustsFontSizeToFitWidth = true
        
        let buttonFontSize: CGFloat = 16.0 * scaleFactor
        skipButton.titleLabel?.font = UIFont(name: Fonts.boldFont, size: buttonFontSize)
        skipButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        continueButton.titleLabel?.font = UIFont(name: Fonts.boldFont, size: buttonFontSize)
        continueButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        nextButton.titleLabel?.font = UIFont(name: Fonts.boldFont, size: buttonFontSize)
        nextButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            circleImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 17),
            circleImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            circleImageView.widthAnchor.constraint(equalTo: circleImageView.heightAnchor),
            
            blueView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 27),
            blueView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -27),
            blueView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -17),
            blueView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            labelsStackView.topAnchor.constraint(equalTo: blueView.topAnchor, constant: 17),
            labelsStackView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 17),
            labelsStackView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: -17),
            labelsStackView.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -17),
            
            skipButton.bottomAnchor.constraint(equalTo: blueView.bottomAnchor, constant: -56),
            skipButton.leadingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 30),
            skipButton.widthAnchor.constraint(equalToConstant: 90),
            skipButton.heightAnchor.constraint(equalToConstant: 58),
            
            continueButton.bottomAnchor.constraint(equalTo: blueView.bottomAnchor, constant: -56),
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 260),
            continueButton.heightAnchor.constraint(equalToConstant: 58),
            
            nextButton.bottomAnchor.constraint(equalTo: blueView.bottomAnchor, constant: -56),
            nextButton.trailingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: -30),
            nextButton.widthAnchor.constraint(equalToConstant: 90),
            nextButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
}

