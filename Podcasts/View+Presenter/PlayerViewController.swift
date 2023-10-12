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
    var isPlay = true
    var timer: Timer!
    
    var increment: CGFloat = 70
    var startOffset: CGFloat = 0
    var index: Int = 0
    
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
        view.addTarget(self, action: #selector(changePodcastItem), for: .touchUpInside)
        return view
    }()
    
    private lazy var forwardButton: UIButton = {
        let view = UIButton()
        view.setImage(.forward, for: .normal)
        view.tintColor = .customBlue
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(changePodcastItem), for: .touchUpInside)
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
        view.setBackgroundImage(.pause, for: .normal)
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
        
        timer = Timer(timeInterval: 1.0, repeats: true, block: { timer in
            print(timer.fireDate)
        })
    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //        playerCollectionView.visibleCells.forEach { cell in
    //            let newCell = cell as! PlayerCollectionViewCell
    //            newCell.updateLayer()
    //        }
    //    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        playerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
            playerCollectionView.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            mainStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 48),
            mainStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -48),
            mainStackView.topAnchor.constraint(equalTo: playerCollectionView.bottomAnchor, constant: 40),
            
            buttonsStackView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor),
            buttonsStackView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor)
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
            
            leftLabel.widthAnchor.constraint(equalToConstant: 50),
            rightLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            labelStackView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor),
            labelStackView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor),
            
            nameLabel.leftAnchor.constraint(equalTo: labelStackView.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: labelStackView.rightAnchor),
            
            channelLabel.leftAnchor.constraint(equalTo: labelStackView.leftAnchor),
            channelLabel.rightAnchor.constraint(equalTo: labelStackView.rightAnchor)
            
            
        ])
    }
    
    private func updateUI() {
        let item = items[indexPath.row]
        nameLabel.text = item.title
        channelLabel.text = item.author
        playerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        playAudio()
    }
    
    private func playAudio() {
        let item = items[indexPath.row]
        print(item.url)
        guard let url = URL(string: item.url) else { return }
        DispatchQueue.main.async {
            self.playerItem = AVPlayerItem(url: url)
            self.player = AVPlayer(playerItem: self.playerItem)
            self.isPlay ? self.player.play() : self.player.pause()
        }
    }
    
    @objc func playerButtonTapped() {
        isPlay.toggle()
        playButton.setBackgroundImage(isPlay ? .pause : .play, for: .normal)
        isPlay ? player.play() : player.pause()
    }
    
    @objc func changePodcastItem(sender: UIButton) {
        if sender == forwardButton, indexPath.row < items.count{
            indexPath.row += 1
        } else if sender == backwardButton, indexPath.row > 0 {
            indexPath.row -= 1
        }
        updateUI()
    }
}

extension PlayerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCollectionViewCell.identifier, for: indexPath) as! PlayerCollectionViewCell
        cell.configure(with: items[indexPath.row].image)
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffset = scrollView.contentOffset.x
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        
        let endOffset = scrollView.contentOffset.x
        
        if endOffset >= startOffset + increment {
            if indexPath.row < items.count - 1 {
                indexPath.row += 1
                updateUI()
            } else {
                playerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        } else if endOffset <= startOffset - increment {
            if indexPath.row > 0 {
                indexPath.row -= 1
                updateUI()
            } else {
                playerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        } else {
            playerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
