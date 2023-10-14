//
//  NavBarApp.swift
//  Podcasts
//
//  Created by Alexander Altman on 13.10.2023.
//

import UIKit

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize the navigation bar appearance
        let font = UIFont(name: Fonts.regularFont, size: 17)
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: font!,
            .foregroundColor: UIColor.black
        ]
        navigationBar.titleTextAttributes = titleTextAttributes
        
        // Customize the back button appearance
        let backButtonImage = UIImage(systemName: "arrow.backward")?.withRenderingMode(.alwaysOriginal)
        navigationBar.backIndicatorImage = backButtonImage
        navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        barButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for: .default)
        barButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for: .compact)
        barButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for: .compactPrompt)
        barButtonItemAppearance.tintColor = .black
    }
}
