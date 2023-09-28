//
//  CustomTextField.swift
//  Podcasts
//
//  Created by Максим Горячкин on 28.09.2023.
//

import UIKit

final class CustomTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    private var imagePadding: UIEdgeInsets {
        UIEdgeInsets(top: 14, left: frame.width-39, bottom: 14, right: 15)
    }
    
    init(placeholder: String) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: imagePadding)
    }
    
    private func setupTextField(placeholder: String) {
        textColor = .black
        font = .manropeBold16
        
        layer.cornerRadius = 26
        layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        layer.borderColor = CGColor(red: 40/255, green: 130/255, blue: 241/255, alpha: 1)
        layer.borderWidth = 1
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.systemGray])
        
        heightAnchor.constraint(equalToConstant: 52).isActive = true
    }
}
