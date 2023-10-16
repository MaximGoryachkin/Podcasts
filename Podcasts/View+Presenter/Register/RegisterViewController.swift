//
//  RegisterViewController.swift
//  Podcasts
//
//  Created by Ольга Шовгенева on 29.09.2023.
//

import UIKit
import Firebase
import GoogleSignIn

class RegisterViewController: UIViewController {
    
    // MARK: - UI Components
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create account"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .labelTextTextColor
        label.font = .manropeRegular14
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let emailField = CustomTextField(fieldType: .email)
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue with Email", for: .normal)
        button.backgroundColor = .customBlue
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let divider: DividerView = {
        let divider = DividerView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    } ()
            
    private let continueWithGoogleButton = GoogleButton()

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
        view.backgroundColor = .customBlue
        
        emailField.delegate = self
        setupUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        self.continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        self.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        continueWithGoogleButton.addTarget(self, action: #selector(didTapContinueWithGoogle), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.addSubview(backgroundView)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailField)
        view.addSubview(continueButton)
        view.addSubview(divider)
        view.addSubview(continueWithGoogleButton)
        loginStack.addArrangedSubview(loginLabel)
        loginStack.addArrangedSubview(loginButton)
        view.addSubview(loginStack)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 192),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailField.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 77),
            emailField.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            emailField.widthAnchor.constraint(equalToConstant: 327),
            emailField.heightAnchor.constraint(equalToConstant: 52),
            
            emailLabel.bottomAnchor.constraint(equalTo: emailField.topAnchor, constant: -8),
            emailLabel.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            
            continueButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 32),
            continueButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 327),
            continueButton.heightAnchor.constraint(equalToConstant: 56),
            
            divider.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 32),
            divider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            divider.heightAnchor.constraint(equalToConstant: 22),

            continueWithGoogleButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 32),
            continueWithGoogleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            continueWithGoogleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            continueWithGoogleButton.heightAnchor.constraint(equalToConstant: 57),
            
            loginStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            loginStack.heightAnchor.constraint(equalToConstant: 24),
            loginStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapContinue() {
        // Email check
        if !Validator.isValidEmail(for: self.emailField.text ?? "") {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        let vc = CompleteAccountViewController()
        vc.emailText = self.emailField.text ?? ""
        navigationController?.pushViewController(vc, animated: true)
        print("DEBUG PRINT:", "didTapContinue")
    }
    
    @objc private func didTapLogin() {
        self.navigationController?.popToRootViewController(animated: true)
        print("DEBUG PRINT:", "didTapLogin")
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension RegisterViewController: UITextFieldDelegate, UIGestureRecognizerDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
