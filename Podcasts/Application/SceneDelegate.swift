//
//  SceneDelegate.swift
//  Podcasts
//
//  Created by Максим Горячкин on 23.09.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        // Setting the UserDefaults
        let onboardingShown = UserDefaults.standard.bool(forKey: "OnboardingShown")
        
        if !onboardingShown {
            // Set the root view controller to OnboardingVC
            window.rootViewController = OnboardingViewController()
            // Set the onboardingShown flag to true
            UserDefaults.standard.set(true, forKey: "OnboardingShown")
        } else {
            // Set the root view controller to MainVC
            //FIXME: change to main view controller after such will be ready
            window.rootViewController = UINavigationController(rootViewController: FavoriteViewController())
        }

        window.makeKeyAndVisible()
        self.window = window
    }
}
