//
//  ProfileSettingPresenter.swift
//  Podcasts
//
//  Created by Артур  Арсланов on 27.09.2023.
//

import UIKit

protocol ProfileSettingViewControllerDelegate {
    func didUpdateUsername(_ username: String, avatar: UIImage)
}

class ProfileSettingViewController: UIViewController {

    // MARK: - Properties
    
    var userInfoHeader = ProfileSetting()
    let accountVC = AccountViewController()
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let frame = CGRect(x: 0, y: 60, width: view.frame.width, height: view.frame.height)
        userInfoHeader = ProfileSetting(frame: frame)
        userInfoHeader.logOutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        view.addSubview(userInfoHeader)
        userInfoHeader.settingTableView.delegate = self
        
        
    }
    
    // MARK: - Selectors
    @objc private func didTapLogout() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.goToController(with: LoginViewController())
            }
        }
    }
    
    
    
}

extension ProfileSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let accountVC = AccountViewController()
            accountVC.delegate = self
            navigationController?.pushViewController(accountVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension ProfileSettingViewController: ProfileSettingViewControllerDelegate {
    func didUpdateUsername(_ username: String, avatar: UIImage) {
        userInfoHeader.usernameLabel.text = username
        userInfoHeader.avatatProfileImage.image = avatar
    }

}
