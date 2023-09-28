//
//  CustomButton.swift
//  Podcasts
//
//  Created by Максим Горячкин on 28.09.2023.
//

import UIKit

class CustomButton: UIButton {
    
    var isCheck: Bool
    var title: String
    var checkedImage: UIImage? {
        isCheck ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
    }
    
    private lazy var checkImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var genderLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.font = .manropeBold16
        view.textColor = .black
        return view
    }()
    
    init(isChecked: Bool, title: String) {
        self.isCheck = isChecked
        self.title = title
        super.init(frame: .zero)
        addSubview(checkImage)
        addSubview(genderLabel)
        clipsToBounds = true
        setupButton(title: title, isChecked: isChecked)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        genderLabel.sizeToFit()
        
        checkImage.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        genderLabel.frame = CGRect(x: 50, y: 0, width: 100, height: 50)
        checkImage.center.y = self.center.y
        genderLabel.center.y = self.center.y
        
    }
    
    private func setupButton(title: String, isChecked: Bool) {
        layer.cornerRadius = 26
        layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        layer.borderColor = CGColor(red: 40/255, green: 130/255, blue: 241/255, alpha: 1)
        layer.borderWidth = 1
        
        heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        genderLabel.text = title
        checkImage.image = checkedImage
    }
    
    func changeImage() {
        isCheck.toggle()
        checkImage.image = checkedImage
    }
}

