//
//  EyeButton.swift
//  Podcasts
//
//  Created by Ольга Шовгенева on 7.10.2023.
//

import UIKit


//MARK: - EyeButton
final class EyeButton: UIButton {
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEyeButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupEyeButton() {
        setImage(UIImage(named: "eye"), for: .normal)
        tintColor = UIColor(named: "eyeButtonColor")
        widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
