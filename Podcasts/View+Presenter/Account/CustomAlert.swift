//
//  CustomAlert.swift
//  Podcasts
//
//  Created by Артур  Арсланов on 03.10.2023.
//

import UIKit

class CustomAlert: UIViewController {
    
    struct Constants{
        static let backgroundAlpha: CGFloat = 0.8
    }
    
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
    
    private let takePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("    Take a photo", for: .normal)
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
//        button.addTarget( action: #selector(chooseImagePickerButton), for: .touchUpInside)
        return button
    }()
    
    private let chooseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("    Choose from your file", for: .normal)
        button.setImage(UIImage(systemName: "folder.fill"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("     Delete Photo", for: .normal)
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.tintColor = .red
        return button
    }()
    
    
    
    func showAlert(viewController: UIViewController){
        
        guard let targetView = viewController.view else {return}
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        alertView.frame = CGRect(x: 30, y: 180, width: 328, height: 340)
        targetView.addSubview(alertView)
        
        
        label.frame = CGRect(x: (328 - alertView.frame.width) / 2 , y: 40, width: alertView.frame.width, height: 40)
        alertView.addSubview(label)
        
        // MARK: - adding a separator
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.gray
        separatorView.alpha = 0.3
        let separatorHeight: CGFloat = 1.0
        let separatorWidth = alertView.frame.width
        separatorView.frame = CGRect(x: 0, y: 100, width: separatorWidth, height: separatorHeight)
        alertView.addSubview(separatorView)
        
        // MARK: - setup and adding button
        
        setupButton(takePhotoButton)
        setupButton(chooseButton)
        setupButton(deleteButton)
        stackView.addArrangedSubview(takePhotoButton)
        stackView.addArrangedSubview(chooseButton)
        stackView.addArrangedSubview(deleteButton)
        
        stackView.frame = CGRect(x: 20, y: 120, width: alertView.frame.width-40, height: 200)
        alertView.addSubview(stackView)
        
        
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = Constants.backgroundAlpha
        }
        
//        takePhotoButton.addTarget(self, action: #selector(chooseImagePickerButton), for: .touchUpInside)
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
    
    @objc func chooseImagePickerButton(sender: UIButton){
        print("chooseImagePickerButton")
    }
}


extension CustomAlert {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
}
