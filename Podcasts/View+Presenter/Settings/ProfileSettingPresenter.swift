//
//  ProfileSettingPresenter.swift
//  Podcasts
//
//  Created by Артур  Арсланов on 27.09.2023.
//

import UIKit



class ProfileSettingPresenter: UIViewController {
    
    // MARK: - Properties
    
    var userInfoHeader: ProfileSetting!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let frame = CGRect(x: 0, y: 60, width: view.frame.width, height: view.frame.height)
        userInfoHeader = ProfileSetting(frame: frame )
        
        view.addSubview(userInfoHeader)
        
    }
    
}
