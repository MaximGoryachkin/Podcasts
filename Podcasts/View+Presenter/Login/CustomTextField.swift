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
    
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
        
    init(fieldType: CustomTextFieldType) {
        self.authFieldType = fieldType
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 24
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.backgroundColor = UIColor(named: "textFieldBackground")
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "textFieldTextColor")!
        ]
        
        switch fieldType {
        case .firstName:
            self.attributedPlaceholder = NSAttributedString(string: "Enter your first name", attributes: attributes)
        case .lastName:
            self.attributedPlaceholder = NSAttributedString(string: "Enter your last name", attributes: attributes)
        case .email:
            self.attributedPlaceholder = NSAttributedString(string: "Enter your email address", attributes: attributes)
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
            
        case .password:
            self.attributedPlaceholder = NSAttributedString(string: "Enter your password", attributes: attributes)
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Override Methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}

