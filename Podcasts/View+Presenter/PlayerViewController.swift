//
//  PlayerViewController.swift
//  Podcasts
//
//  Created by Максим Горячкин on 29.09.2023.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    var items: [Item]!
    var indexPath: IndexPath!
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
    
    deinit {
        print("Deinit PLayer")
    }
    
    private lazy var playerCollectionView: UICollectionView = {
        let layout = CarouselLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        layout.sectionInset = UIEdgeInsets(top: 0, left: 57, bottom: 0, right: 57)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var shuffleButton: UIButton = {
        let view = UIButton()
        view.setImage(.shuffle, for: .normal)
        view.tintColor = .systemGray
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backwardButton: UIButton = {
        let view = UIButton()
        view.setImage(.backward, for: .normal)
        view.tintColor = .customBlue
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var forwardButton: UIButton = {
        let view = UIButton()
        view.setImage(.forward, for: .normal)
        view.tintColor = .customBlue
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var repeatButton: UIButton = {
        let view = UIButton()
        view.setImage(.repeatImage, for: .normal)
        view.tintColor = .systemGray
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var playButton: UIButton = {
        let view = UIButton()
        view.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        view.tintColor = .customBlue
        view.setBackgroundImage(.play, for: .normal)
        view.imageView?.contentMode = .scaleAspectFill
        view.addTarget(self, action: #selector(playerButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sliderStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillProportionally
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var leftLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.font = .manropeRegular14
        view.text = "00.00"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var rightLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.font = .manropeRegular14
        view.text = "00.00"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var slider: UISlider = {
        let view = UISlider()
        view.value = 5
        view.minimumValue = 0.0
        view.maximumValue = 10.0
        view.minimumTrackTintColor = .customBlue
        view.maximumTrackTintColor = .customBlue
        view.thumbTintColor = .customBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = .manropeBold16
        view.text = "Name of Podcast"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var channelLabel: UILabel = {
        let view = UILabel()
        view.font = .manropeRegular16
        view.text = "Name of channel"
        view.textColor = .systemGray
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(playerCollectionView)
        view.addSubview(mainStackView)
        addSubviews(stack: mainStackView, views: labelStackView, sliderStackView, buttonsStackView)
        addSubviews(stack: buttonsStackView, views: shuffleButton, backwardButton, playButton, forwardButton, repeatButton)
        addSubviews(stack: sliderStackView, views: leftLabel, slider, rightLabel)
        addSubviews(stack: labelStackView, views: nameLabel, channelLabel)
        setupUI()
        
        playerCollectionView.dataSource = self
        playerCollectionView.delegate = self
        playerCollectionView.register(PlayerCollectionViewCell.self, forCellWithReuseIdentifier: PlayerCollectionViewCell.identifier)
        
        navigationItem.title = "Player"
        updateUI()
        playAudio()
    }
    
    private func addSubviews(stack: UIStackView, views: UIView...) {
        for view in views {
            stack.addArrangedSubview(view)
        }
    }
    
    private func setupUI() {
        NSLayoutConstraint.activate([
            playerCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            playerCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            playerCollectionView.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            mainStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 48),
            mainStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -48),
            mainStackView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2 - 50),
            
            buttonsStackView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor),
            buttonsStackView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor),
            //            buttonsStackView.heightAnchor.constraint(equalToConstant: 70)
        ])
        NSLayoutConstraint.activate([
            shuffleButton.heightAnchor.constraint(equalToConstant: 20),
            shuffleButton.widthAnchor.constraint(equalToConstant: 20),
            backwardButton.heightAnchor.constraint(equalToConstant: 20),
            backwardButton.widthAnchor.constraint(equalToConstant: 20),
            forwardButton.heightAnchor.constraint(equalToConstant: 20),
            forwardButton.widthAnchor.constraint(equalToConstant: 20),
            repeatButton.heightAnchor.constraint(equalToConstant: 20),
            repeatButton.widthAnchor.constraint(equalToConstant: 20),
            playButton.heightAnchor.constraint(equalToConstant: 70),
            playButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            sliderStackView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor),
            sliderStackView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor),
            //            sliderStackView.heightAnchor.constraint(equalToConstant: 20),
            
            leftLabel.widthAnchor.constraint(equalToConstant: 50),
            rightLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            labelStackView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor),
            labelStackView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor),
            //            labelStackView.heightAnchor.constraint(equalToConstant: 20),
            
            nameLabel.leftAnchor.constraint(equalTo: labelStackView.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: labelStackView.rightAnchor),
            //            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            //            channelLabel.heightAnchor.constraint(equalToConstant: 30),
            channelLabel.leftAnchor.constraint(equalTo: labelStackView.leftAnchor),
            channelLabel.rightAnchor.constraint(equalTo: labelStackView.rightAnchor)
            
        ])
    }
    
    private func updateUI() {
//        let item = items[indexPath.row]
//        nameLabel.text = item.title
//        channelLabel.text = item.author
    }
    
    private func playAudio() {
//        let item = items[indexPath.row]
//        print(item.url)
//        guard let url = URL(string: item.url) else { return }
//        DispatchQueue.main.async {
//            self.playerItem = AVPlayerItem(url: url)
//            self.player = AVPlayer(playerItem: self.playerItem)
//            self.player.play()
//        }
    }
    
    @objc func playerButtonTapped() {
        
    }
}

extension PlayerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCollectionViewCell.identifier, for: indexPath) as! PlayerCollectionViewCell
        cell.configure(with: .checkmark)
        return cell
    }
}
