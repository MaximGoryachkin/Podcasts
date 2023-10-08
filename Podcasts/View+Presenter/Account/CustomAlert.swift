//
//  CustomAlert.swift
//  Podcasts
//
//  Created by Артур  Арсланов on 03.10.2023.
//

import UIKit

class CustomAlert: UIViewController {
    // MARK: - Constants
    struct Constants{
        static let backgroundAlpha: CGFloat = 0.8
    }
    
    // MARK: - Views
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Change your picture"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - Buttons
     let takePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("    Take a photo", for: .normal)
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
//        button.addTarget( action: #selector(chooseImagePickerButton), for: .touchUpInside)
        return button
    }()
    
     let chooseFromYourFileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("    Choose from your file", for: .normal)
        button.setImage(UIImage(systemName: "folder.fill"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        return button
    }()
    
     let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("     Delete Photo", for: .normal)
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.tintColor = .red
        return button
    }()
    
    // MARK: - Properties
    private var myTargetView: UIView?
    
    // MARK: - Public Methods
    func showAlert(viewController: UIViewController) {
        guard let targetView = viewController.view else {
            return
        }
        
        myTargetView = targetView
        // Set up background view
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        // Set up alert view
        alertView.frame = CGRect(x: (targetView.bounds.width - 328) / 2, y: targetView.bounds.height, width: 328, height: 340)
        targetView.addSubview(alertView)
        
        // Set up label
        label.frame = CGRect(x: (328 - alertView.frame.width) / 2, y: 40, width: alertView.frame.width, height: 40)
        alertView.addSubview(label)
        
        // Add separator
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.gray
        separatorView.alpha = 0.3
        let separatorHeight: CGFloat = 1.0
        let separatorWidth = alertView.frame.width
        separatorView.frame = CGRect(x: 0, y: 100, width: separatorWidth, height: separatorHeight)
        alertView.addSubview(separatorView)
        
        // MARK: - Setup and adding button
        setupButton(takePhotoButton)
        setupButton(chooseFromYourFileButton)
        setupButton(deleteButton)
        
        stackView.addArrangedSubview(takePhotoButton)
        stackView.addArrangedSubview(chooseFromYourFileButton)
        stackView.addArrangedSubview(deleteButton)
        
        stackView.frame = CGRect(x: 20, y: 120, width: alertView.frame.width - 40, height: 200)
        alertView.addSubview(stackView)
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = Constants.backgroundAlpha
        } completion: { (_) in
            UIView.animate(withDuration: 0.3) {
                self.alertView.center = targetView.center
            }
        }
    }
    
    
    // MARK: - Method
    
    func setupButton(_ button: UIButton){
        button.contentHorizontalAlignment = .left
        button.configuration = UIButton.Configuration.plain()
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10)
        button.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        button.titleLabel?.font = .manropeBold16
        button.layer.cornerRadius = 10
    }
    
    
    // MARK: - Hide Alert
    
      func hideAlert() {
        guard let targetView = myTargetView else { return }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0
            self.alertView.center = targetView.center
        }) { (_) in
            self.backgroundView.removeFromSuperview()
            self.alertView.removeFromSuperview()
        }
    }
    
    func addTapGestureToHideAlert() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: backgroundView)
        if !alertView.frame.contains(point) {
            hideAlert()
        }
    }
    
}






