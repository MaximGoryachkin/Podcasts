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
    }
}

// MARK: - extension
extension CustomTabBarController {
// MARK: - flow funcs
    private func generateTabBar() {
        viewControllers = [
        makeVC(vc: ViewController(), image: UIImage(named: "home/inactive"), selectedImage: UIImage(named: "home/active")),
        makeVC(vc: SearchViewController(), image: UIImage(named: "search/inactive"), selectedImage: UIImage(named: "search/active")),
        makeVC(vc: UIViewController(), image: UIImage(named: "bookmark/inactive"), selectedImage: UIImage(named: "bookmark/active")),
        makeVC(vc: UIViewController(), image: UIImage(named: "settings/inactive"), selectedImage: UIImage(named: "settings/active"))
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
        
        roundLayer.shadowColor = UIColor(red: 0.212, green: 0.224, blue: 0.298, alpha: 0.08).cgColor
        roundLayer.shadowOffset = CGSize(width: 10, height: 14)
        roundLayer.shadowOpacity = 1
        roundLayer.shadowRadius = 48
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 6.5
        tabBar.itemPositioning = .centered
        roundLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
