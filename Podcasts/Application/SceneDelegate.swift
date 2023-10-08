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
        self.setupWindow(with: scene)
        //         Setting the UserDefaults
        self.checkAuthentication()
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    let onboardingShown = UserDefaults.standard.bool(forKey: "OnboardingShown")

    public func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            self.goToController(with:  LoginViewController())
        } else {
            if !onboardingShown {
                // Set the root view controller to OnboardingVC
                self.window?.rootViewController = OnboardingViewController()
                // Set the onboardingShown flag to true
                UserDefaults.standard.set(true, forKey: "OnboardingShown")
            } else {
                // Set the root view controller to MainVC
                //FIXME: change to main view controller after such will be ready
                self.window?.rootViewController = UINavigationController(rootViewController: CustomTabBarController())
            }
//            self.goToController(with: HomeController())
        }
    }
    
    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.window?.layer.opacity = 0
                
            } completion: { [weak self] _ in
                
                let nav = UINavigationController(rootViewController: viewController)
                nav.modalPresentationStyle = .fullScreen
                self?.window?.rootViewController = nav
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                }
            }
        }
    }
}
