//
//  SceneDelegate.swift
//  Podcasts
//
//  Created by Максим Горячкин on 23.09.2023.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupWindow(with: scene)
        goToController(with: LoginViewController())
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    public func checkAuthentication() {
        let onboardingShown = UserDefaults.standard.bool(forKey: "OnboardingShown")
        
        if !onboardingShown {
            // Set the root view controller to OnboardingVC
            goToController(with: OnboardingViewController())
            // Set the onboardingShown flag to true
        } else {
            // Set the root view controller to MainVC
            //FIXME: change to main view controller after such will be ready
            goToController(with: CustomTabBarController())
        }
        
    }
    
    func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.window?.layer.opacity = 0
                
            } completion: { [weak self] _ in
                
                let vc = viewController
                vc.modalPresentationStyle = .fullScreen
                self?.window?.rootViewController = vc
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                }
            }
        }
    }
}
