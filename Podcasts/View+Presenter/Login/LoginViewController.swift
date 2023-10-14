//
//  LoginViewController.swift
//  Podcasts
//
//  Created by Ольга Шовгенева on 27.09.2023.
//

import UIKit
import GoogleSignIn
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: - UI Components
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "E-mail"
        label.textColor = .labelTextTextColor
        label.font = .manropeRegular14
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let emailField = CustomTextField(fieldType: .email)
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .labelTextTextColor
        label.font = .manropeRegular14
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = .customBlue
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let newUserStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 3
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private let newUserLabel: UILabel = {
        let label = UILabel()
        label.text = "Do you not have an account?"
        label.textColor = .systemGray
        return label
    } ()
    
    private let newUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(UIColor.customGreen, for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let divider: DividerView = {
        let divider = DividerView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    } ()
            
    private let continueWithGoogleButton = GoogleButton()
    
    private let eyeButton = EyeButton()
    
    private var isPrivate = true

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupTF()
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        continueWithGoogleButton.addTarget(self, action: #selector(didTapContinueWithGoogle), for: .touchUpInside)
        eyeButton.addTarget(self, action: #selector(displayBookMarks), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupTF() {
        emailField.delegate = self
        passwordField.delegate = self
        passwordField.rightView = eyeButton
        passwordField.rightViewMode = .always
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(emailLabel)
        view.addSubview(emailField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(divider)
        view.addSubview(continueWithGoogleButton)

        newUserStack.addArrangedSubview(newUserLabel)
        newUserStack.addArrangedSubview(newUserButton)
        view.addSubview(newUserStack)
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 102),
            emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            emailField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 6),
            emailField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            emailField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            emailField.heightAnchor.constraint(equalToConstant: 45),

            passwordLabel.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12),
            passwordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 6),
            passwordField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            passwordField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            passwordField.heightAnchor.constraint(equalToConstant: 45),

            signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 24),
            signInButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            signInButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            signInButton.heightAnchor.constraint(equalToConstant: 57),
            
            divider.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 45),
            divider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            divider.heightAnchor.constraint(equalToConstant: 22),

            continueWithGoogleButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 56),
            continueWithGoogleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            continueWithGoogleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            continueWithGoogleButton.heightAnchor.constraint(equalToConstant: 57),

            newUserStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            newUserStack.heightAnchor.constraint(equalToConstant: 24),
            newUserStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapSignIn() {
        let loginRequest = LoginUserRequest(
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
        )
        
        // Email check
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.signIn(with: loginRequest) { error in
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    @objc private func didTapNewUser() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        print("DEBUG PRINT:", "didTapNewUser")
    }
    
    @objc private func didTapContinueWithGoogle() {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
            return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { result, error in

                if let error = error {
                    AlertManager.showSignInErrorAlert(on: self, with: error)
                    return
                }
                
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            }
        }
        

        print("DEBUG PRINT:", "didTapContinueWithGoogle")
    }
    
    @objc private func displayBookMarks() {
        let imageName = isPrivate ? "hidden" : "show"
        
        passwordField.isSecureTextEntry.toggle()
        eyeButton.setImage(UIImage(named: imageName), for: .normal)
        isPrivate.toggle()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension LoginViewController: UITextFieldDelegate, UIGestureRecognizerDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
