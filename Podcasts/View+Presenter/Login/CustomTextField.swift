//
//  CustomTextField.swift
//  Podcasts
//
//  Created by Ольга Шовгенева on 29.09.2023.
//

import UIKit

class CustomTextField: UITextField {

    enum CustomTextFieldType {
        case firstName
        case lastName
        case email
        case password
    }
    
    private let authFieldType: CustomTextFieldType
    
    // Добавьте свойство для кнопки
    private let actionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24) // Размер кнопки
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        return button
    }()
        
    init(fieldType: CustomTextFieldType) {
        self.authFieldType = fieldType
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 24
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        switch fieldType {
        case .firstName:
            self.placeholder = "Username"
        case .lastName:
            self.placeholder = "Username"
        case .email:
            self.placeholder = "Enter your email address"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
            
        case .password:
            self.placeholder = "Enter your password"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
            
            self.rightViewMode = .always
            self.rightView = actionButton
            
            // Добавьте таргет (обработчик) для кнопки
            actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func actionButtonTapped() {
        // Инвертируйте значение свойства isSecureTextEntry
        isSecureTextEntry.toggle()

        // Обновите изображение кнопки в зависимости от значения isSecureTextEntry
        if isSecureTextEntry {
            if let image = UIImage(systemName: "eye.fill") {
                actionButton.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(systemName: "eye.slash.fill") {
                actionButton.setImage(image, for: .normal)
            }
        }
    }
}

