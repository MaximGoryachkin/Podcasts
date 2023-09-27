//
//  CustomTabBarController.swift
//  Podcasts
//
//  Created by Miras Maratov on 27.09.2023.
//

import UIKit

class CustomTabBarController : UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.backgroundColor = .clear
    }
}

extension CustomTabBarController {
    private func setUpView () {
        delegate = self
        createTabBar()
    }
    
    private func createTabBar() {
        viewControllers = [
        makeVC(vc: ViewController(), image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill")),
        makeVC(vc: UIViewController(), image:UIImage(systemName: "magnifyingglass.circle") , selectedImage: UIImage(systemName: "magnifyingglass.circle.fill")),
        makeVC(vc: UIViewController(), image: UIImage(systemName: "bookmark.circle"), selectedImage: UIImage(systemName: "bookmark.circle.fill")),
        makeVC(vc: UIViewController(), image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        ]
    }
    
    private func makeVC(vc: UIViewController, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selectedImage
        return vc
    }
}
