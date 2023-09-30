//
//  AccountViewController.swift
//  Podcasts
//
//  Created by Максим Горячкин on 28.09.2023.
//

import UIKit

class AccountViewController: UIViewController {
    
    private var contentSize : CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 200)
    }
    
    private var isMale = true
    
    private lazy var scroolView: UIScrollView = {
        let view = UIScrollView()
        view.contentSize = contentSize
        view.frame = self.view.bounds
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var mainStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .top
        view.contentMode = .scaleAspectFill
        view.spacing = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.image = .checkmark
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
        CustomProfileTextField(placeholder: "Enter First Name")
    }()
    
    private lazy var lastLabel: UILabel = {
        let view = UILabel()
        view.text = "Last Name"
        view.font = .manropeRegular14
        view.textColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var lastTextField: UITextField = {
        CustomProfileTextField(placeholder: "Enter Last Name")
    }()
    
    private lazy var emailLabel: UILabel = {
        let view = UILabel()
        view.text = "E-Mail"
        view.font = .manropeRegular14
        view.textColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        CustomProfileTextField(placeholder: "Enter E-Mail")
    }()
    
    private lazy var birthLabel: UILabel = {
        let view = UILabel()
        view.text = "Date of Birth"
        view.font = .manropeRegular14
        view.textColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var birthTextField: UITextField = {
        let view = CustomProfileTextField(placeholder: "Enter Date of Birth")
        view.inputView = datePicker
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.image = .calendar
        view.rightView = imageView
        view.rightViewMode = .always
        return view
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .inline
        return view
    }()
    
    private lazy var genderLabel: UILabel = {
        let view = UILabel()
        view.text = "Gender"
        view.font = .manropeRegular14
        view.textColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttonStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.contentMode = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var maleButton: UIButton = {
        let view = CustomButton(isChecked: false, title: "Male")
        view.isCheck = isMale
        view.addTarget(self, action: #selector(genderButtonPressed), for: .touchUpInside)
        return view
    }()
    
    private lazy var femaleButton: UIButton = {
        let view = CustomButton(isChecked: false, title: "Female")
        view.isCheck = !isMale
        view.addTarget(self, action: #selector(genderButtonPressed), for: .touchUpInside)
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Save Changes", for: .normal)
        view.titleLabel?.font = .manropeBold16
        view.backgroundColor = .customBlue
        view.setTitleColor(.white, for: .normal)
        view.setTitleColor(.systemGray, for: .highlighted)
        view.layer.cornerRadius = 26
        view.layer.borderWidth = 1
        view.layer.borderColor = CGColor(red: 40/255, green: 130/255, blue: 241/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(saveButtonPressed(sender: )), for: .allTouchEvents)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scroolView)
        scroolView.addSubview(contentView)
        contentView.addSubview(profileImage)
        contentView.addSubview(mainStack)
        addSubviews(main: mainStack, views: firstLabel, firstTextField, lastLabel, lastTextField, emailLabel, emailTextField, birthLabel, birthTextField, genderLabel, buttonStack)
        addSubviews(main: buttonStack, views: maleButton, femaleButton)
        view.addSubview(saveButton)
        setupUI()
        setupDatePicker()
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
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            profileImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            mainStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            mainStack.rightAnchor.constraint(equalTo: contentView.rightAnchor , constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            firstTextField.widthAnchor.constraint(equalToConstant: contentView.frame.width - 40),
            lastTextField.widthAnchor.constraint(equalToConstant: contentView.frame.width - 40),
            emailTextField.widthAnchor.constraint(equalToConstant: contentView.frame.width - 40),
            birthTextField.widthAnchor.constraint(equalToConstant: contentView.frame.width - 40),
            maleButton.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2 - 30),
            femaleButton.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2 - 30)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 52),
            saveButton.widthAnchor.constraint(equalToConstant: contentView.frame.width - 40),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setupDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let emptyButton = UIBarButtonItem()
        toolBar.setItems([emptyButton, doneButton], animated: true)
        birthTextField.inputAccessoryView = toolBar
        birthTextField.inputView = datePicker
    }
    
    @objc func donePressed() {
        birthTextField.text = DateFormatter.localizedString(from: datePicker.date, dateStyle: .long, timeStyle: .none)
        self.view.endEditing(true)
    }
    
    @objc func genderButtonPressed(sender: CustomButton) {
        print(sender.title)
        let maleButton = maleButton as! CustomButton
        let femaleButton = femaleButton as! CustomButton
        if sender.title == "Male" {
            maleButton.isCheck = true
            femaleButton.isCheck = false
        } else if sender.title == "Female" {
            femaleButton.isCheck = true
            maleButton.isCheck = false
            
        }
    }
//
//    @objc func femaleGenderBubbotPressed() {
//        let button = femaleButton as! CustomButton
//        if isMale {
//            button.changeImage()
//        }
//    }
    
    @objc func saveButtonPressed(sender: UIButton) {
        
    }
    
}


extension AccountViewController: UIPickerViewDelegate {
    
}
