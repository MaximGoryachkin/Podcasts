//
//  CTabBar.swift
//  Podcasts
//
//  Created by Miras Maratov on 28.09.2023.
//

import UIKit

class CustomTabBarController: UITabBarController {
// MARK: - life cycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarApearence()
        setupAppearance()
    }
}

// MARK: - extension
extension CustomTabBarController {
// MARK: - flow funcs
    private func generateTabBar() {
        viewControllers = [
        makeVC(vc: HomeViewController(), 
               image: .homeInactive,
               selectedImage: .homeActive),
        makeVC(vc: SearchViewController(),
               image: .searchInactive,
               selectedImage: .searchActive),
        makeVC(vc: NavigationViewController(rootViewController: FavoriteViewController()),
               image: .bookmarkInactive,
               selectedImage: .bookmarkActive),
        makeVC(vc: NavigationViewController(rootViewController: ProfileSettingViewController()),
               image: .settingsInactive,
               selectedImage: .settingsActive)
        ]
    }
    
    private func makeVC(vc: UIViewController, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selectedImage
        return vc
    }
    
    private func setTabBarApearence() {
        let positionX: CGFloat = 24
        let positionY: CGFloat = 14
        let width = tabBar.bounds.width - positionX * 2
        let height = 68.0
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionX, y: tabBar.bounds.minY - positionY, width: width, height: height), cornerRadius: 20)
        roundLayer.path = bezierPath.cgPath
        
        roundLayer.shadowColor = CGColor(gray: 0.8, alpha: 1)
        roundLayer.shadowOffset = CGSize(width: 10, height: 14)
        roundLayer.shadowOpacity = 1
        roundLayer.shadowRadius = 30
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 6.5
//        tabBar.itemPositioning = .centered
        roundLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = .none
        appearance.backgroundImageContentMode = .scaleAspectFill
        appearance.shadowColor = .clear
        appearance.stackedItemPositioning = .centered
        appearance.stackedItemSpacing = 5
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
