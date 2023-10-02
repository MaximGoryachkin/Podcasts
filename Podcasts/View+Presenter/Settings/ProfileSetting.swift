//
//  ProfileSetting.swift
//  Podcasts
//
//  Created by Артур  Арсланов on 27.09.2023.
//

import UIKit

struct SettingOption {
    let title: String
    let icon: UIImage?
    let iconBackground: UIColor
}

class ProfileSetting: UIView {

    // MARK: - Properties
    
    var profileSettings = ProfileSettingViewController()
    
    var models = [SettingOption]()
    
     var avatatProfileImage: UIImageView = {
         let avatar = UIImageView()
         avatar.clipsToBounds = true
         avatar.contentMode = .scaleAspectFill
         avatar.translatesAutoresizingMaskIntoConstraints = false
         avatar.image = UIImage(named: "avatar")
//         avatar.layer.shadowColor = UIColor.black.cgColor
//         avatar.layer.shadowOffset = CGSize(width: 0, height: 10)
//         avatar.layer.shadowOpacity = 0.3
//         avatar.layer.shadowRadius = 8
//         avatar.layer.masksToBounds = false
         return avatar
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.font = UIFont.manropeBold16
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    let subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.manropeRegular16
        label.text = "Love,life and chill"
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var settingTableView = UITableView()
    
    
    let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1.3
        button.layer.borderColor = CGColor(red: 40/255, green: 130/255, blue: 241/255, alpha: 1)
        button.titleLabel?.textColor = UIColor.customBlue
        button.tintColor = UIColor.customBlue
        button.titleLabel?.font = UIFont.manropeBold16
        button.setTitle("Log Out", for: .normal)
        return button
    }()
    
    
    // MARK: - Method
    
    func setupTable() {
        settingTableView = UITableView()
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.rowHeight = 80
        settingTableView.translatesAutoresizingMaskIntoConstraints = false
        settingTableView.alwaysBounceVertical = false
        
        settingTableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
    }
    
    func configure() {
        models.append(SettingOption(title: "Account Setting",
                                    icon: UIImage.profile,
                                    iconBackground: UIColor.customGray))
        models.append(SettingOption(title: "Change Password",
                                    icon: UIImage.shield,
                                    iconBackground: UIColor.customGray))
        models.append(SettingOption(title: "Forget Password",
                                    icon: UIImage.lock,
                                    iconBackground: UIColor.customGray))
    }
    
   
    
    
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
        let profileImageDimension: CGFloat = 60
        
        addSubview(avatatProfileImage)
        avatatProfileImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        avatatProfileImage.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        avatatProfileImage.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        avatatProfileImage.layer.cornerRadius = 15
        
        
        addSubview(usernameLabel)
        usernameLabel.centerYAnchor.constraint(equalTo: avatatProfileImage.centerYAnchor, constant: -15).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: avatatProfileImage.rightAnchor, constant: 12).isActive = true
        
        addSubview(subLabel)
        subLabel.centerYAnchor.constraint(equalTo: avatatProfileImage.centerYAnchor, constant: 10).isActive = true
        subLabel.leftAnchor.constraint(equalTo: avatatProfileImage.rightAnchor, constant: 12).isActive = true
        
        setupTable()
        addSubview(settingTableView)
        settingTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        settingTableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -18).isActive = true
        settingTableView.topAnchor.constraint(equalTo: avatatProfileImage.bottomAnchor, constant: 35).isActive = true
        settingTableView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        addSubview(logOutButton)
        logOutButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logOutButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        logOutButton.rightAnchor.constraint(equalTo: rightAnchor, constant:  -18).isActive = true
        
        // FIXME
        
        if frame.height < 700 {
            logOutButton.topAnchor.constraint(equalTo: settingTableView.bottomAnchor, constant: 80).isActive = true
            logOutButton.layer.cornerRadius = 30
        } else {
            logOutButton.topAnchor.constraint(equalTo: settingTableView.bottomAnchor, constant: 230).isActive = true
            logOutButton.layer.cornerRadius = 35

        }
        logOutButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/12).isActive = true

        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - Extension

extension ProfileSetting: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingsCell.identifier,
            for: indexPath) as? SettingsCell else {
            print("Error tableView")
            return UITableViewCell()
        }
        
        self.settingTableView.separatorStyle = .none
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
