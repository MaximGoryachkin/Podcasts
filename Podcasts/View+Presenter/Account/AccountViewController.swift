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
    
    var delegate: ProfileSettingViewControllerDelegate!
    
    private var isMale = true
    private let customAlert = CustomAlert()
        
    private lazy var scroolView: UIScrollView = {
        let view = UIScrollView()
        view.contentSize = contentSize
        view.frame = self.view.bounds
        view.backgroundColor = .white
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
        var view = UIImageView()
        view.image = UIImage(named: "avatar")
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var editSymbol: UIImageView = {
        let symbol = UIImageView()
        symbol.image = UIImage(systemName: "pencil.circle.fill")
        symbol.translatesAutoresizingMaskIntoConstraints = false
        symbol.layer.cornerRadius = 18
        symbol.layer.borderColor = UIColor.white.cgColor
        symbol.layer.borderWidth = 4
        return symbol
    }()
    
    private lazy var photoSelectionAlertButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("", for: .normal)
            button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
            button.layer.cornerRadius = 50
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
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
        CustomAccountTextField(placeholder: "Enter First Name")
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
        CustomAccountTextField(placeholder: "Enter Last Name")
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
        CustomAccountTextField(placeholder: "Enter E-Mail")
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
        let view = CustomAccountTextField(placeholder: "Enter Date of Birth")
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
        view.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        tabBarController?.tabBar.isHidden = true
        view.addSubview(scroolView)
        scroolView.addSubview(contentView)
        contentView.addSubview(profileImage)
        contentView.addSubview(editSymbol)
        contentView.addSubview(photoSelectionAlertButton)
        contentView.addSubview(mainStack)
        addSubviews(main: mainStack, views: firstLabel, firstTextField, lastLabel, lastTextField, emailLabel, emailTextField, birthLabel, birthTextField, genderLabel, buttonStack)
        addSubviews(main: buttonStack, views: maleButton, femaleButton)
        view.addSubview(saveButton)
        setupUI()
        setupDatePicker()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(tapGesture)
        customAlert.takePhotoButton.addTarget(self, action: #selector(chooseImagePickerButton), for: .touchUpInside)
        customAlert.chooseFromYourFileButton.addTarget(self, action: #selector(chooseImagePickerButton), for: .touchUpInside)
        customAlert.deleteButton.addTarget(self, action: #selector(chooseImagePickerButton), for: .touchUpInside)
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
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profileImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            editSymbol.heightAnchor.constraint(equalToConstant: 38),
            editSymbol.widthAnchor.constraint(equalToConstant: 38),
            editSymbol.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            editSymbol.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            photoSelectionAlertButton.heightAnchor.constraint(equalToConstant: 100),
            photoSelectionAlertButton.widthAnchor.constraint(equalToConstant: 100),
            photoSelectionAlertButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            photoSelectionAlertButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
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
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func chooseImagePickerButton(sender: UIButton) {
        if sender == customAlert.takePhotoButton {
                chooseImagePicker(source: .camera)
        } else if sender == customAlert.chooseFromYourFileButton {
                chooseImagePicker(source: .photoLibrary)
        }else if sender == customAlert.deleteButton {
            profileImage.image = .checkmark
            customAlert.hideAlert()
            
        }
    }
    
    
    
    @objc func showAlert() {
        customAlert.showAlert(viewController: self)
        customAlert.addTapGestureToHideAlert()
    }
//
//    @objc func femaleGenderBubbotPressed() {
//        let button = femaleButton as! CustomButton
//        if isMale {
//            button.changeImage()
//        }
//    }
    
    @objc func saveButtonPressed(sender: UIButton) {
        let firstName = firstTextField.text ?? ""
        let lastName = lastTextField.text ?? ""
        let username = firstName + " " + lastName
        
        delegate?.didUpdateUsername(username, avatar: profileImage.image!)
        
        
        navigationController?.popViewController(animated: true)
    }
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
}

extension AccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImage.image = selectedImage
            profileImage.image = selectedImage
            customAlert.hideAlert()
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}


