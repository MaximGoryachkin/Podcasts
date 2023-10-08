//
//  CompleteAccountViewController.swift
//  Podcasts
//
//  Created by Ольга Шовгенева on 29.09.2023.
//

import UIKit

class CompleteAccountViewController: UIViewController {
    
    var emailText = ""
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Complete your account"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.textColor = .gray
        label.font = .manropeRegular14
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let firstNameField = CustomTextField(fieldType: .firstName)
    
    private let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Last Name"
        label.textColor = .gray
        label.font = .manropeRegular14
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let lastNameField = CustomTextField(fieldType: .lastName)
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .gray
        label.font = .manropeRegular14
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let emailField = CustomTextField(fieldType: .email)
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .gray
        label.font = .manropeRegular14
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm Password"
        label.textColor = .gray
        label.font = .manropeRegular14
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let confirmPasswordField = CustomTextField(fieldType: .password)
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .customBlue
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let loginStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 3
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.textColor = .systemGray
        return label
    } ()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.customPurple, for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Sign Up"
        let backButtonImage = UIImage(named: "customBackButtonImage")
        let customBackButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = customBackButton
        emailField.text = emailText
        setupUI()
        
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        self.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(firstNameLabel)
        view.addSubview(firstNameField)
        view.addSubview(lastNameLabel)
        view.addSubview(lastNameField)
        view.addSubview(emailLabel)
        view.addSubview(emailField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(confirmPasswordLabel)
        view.addSubview(confirmPasswordField)
        view.addSubview(signUpButton)
        loginStack.addArrangedSubview(loginLabel)
        loginStack.addArrangedSubview(loginButton)
        view.addSubview(loginStack)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            firstNameLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 16),
            firstNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            firstNameField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 6),
            firstNameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            firstNameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            firstNameField.heightAnchor.constraint(equalToConstant: 52),
            
            lastNameLabel.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 16),
            lastNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            lastNameField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 6),
            lastNameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            lastNameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            lastNameField.heightAnchor.constraint(equalToConstant: 52),
            
            emailLabel.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            emailField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 6),
            emailField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            emailField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            emailField.heightAnchor.constraint(equalToConstant: 52),
            
            passwordLabel.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16),
            passwordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 6),
            passwordField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            passwordField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            passwordField.heightAnchor.constraint(equalToConstant: 52),
            
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            confirmPasswordField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 6),
            confirmPasswordField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            confirmPasswordField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            confirmPasswordField.heightAnchor.constraint(equalToConstant: 52),
            
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor, constant: 24),
            signUpButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            signUpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            signUpButton.heightAnchor.constraint(equalToConstant: 56),
            
            loginStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            loginStack.heightAnchor.constraint(equalToConstant: 24),
            loginStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapSignUp() {
        let registerUserRequest = RegiserUserRequest(
            firstName: self.firstNameField.text ?? "",
            lastName: self.lastNameField.text ?? "",
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
        )
        
        let confirmPassword = self.confirmPasswordField.text ?? ""
        
        // firstName check
        if !Validator.isValidFirstName(for: registerUserRequest.firstName) {
            AlertManager.showInvalidFirstNameAlert(on: self)
            return
        }
        
        // lastName check
        if !Validator.isValidLastName(for: registerUserRequest.lastName) {
            AlertManager.showInvalidLastNameAlert(on: self)
            return
        }
        
        // Email check
        if !Validator.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        if registerUserRequest.password != confirmPassword {
            AlertManager.showInvalidConfirmPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
    }
    
    @objc private func didTapLogin() {
        self.navigationController?.popToRootViewController(animated: true)
        print("DEBUG PRINT:", "didTapLogin")
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
