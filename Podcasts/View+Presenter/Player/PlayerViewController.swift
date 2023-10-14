//
//  PlayerViewController.swift
//  Podcasts
//
//  Created by Максим Горячкин on 29.09.2023.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    // MARK: Public proreties
    
    var items: [Item]!
    var indexPath: IndexPath!
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
    var isPlay = true
    var timer: Timer!
    var timeObserverToken: Any!
    var increment: CGFloat = 70
    var startOffset: CGFloat = 0
    var index: Int = 0
    
    deinit {
        print("Deinit PLayer")
    }
    
    // MARK: Private proreties
    
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var rightLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.font = .manropeRegular14
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var slider: UISlider = {
        let view = UISlider()
        view.value = 0
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
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var channelLabel: UILabel = {
        let view = UILabel()
        view.font = .manropeRegular16
        view.textColor = .systemGray
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Override methods
    
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
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        playerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: Private methods
    
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
        self.playerCollectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: true)
        self.leftLabel.text = "00:00"
        self.rightLabel.text = "--:--"
        self.nameLabel.text = item.title
        self.channelLabel.text = item.author
        DispatchQueue.global(qos: .utility).sync {
            self.playAudio()
        }
    }
    
    private func playAudio() {
        guard let url = URL(string: items[indexPath.row].url) else { return }
        let item = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: item)
        self.player = player
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.slider.value = Float(item.currentTime().seconds)
            self?.leftLabel.text = item.currentTime().convertToMinutesSeconds()
            self?.rightLabel.text = item.duration.convertToMinutesSeconds()
            self?.slider.maximumValue = Float(item.duration.seconds)
        }
        if isPlay {
            self.player.play()
        }
    }
    
    // MARK: Objc methhods
    
    @objc func playerButtonTapped() {
        isPlay.toggle()
        playButton.setBackgroundImage(isPlay ? .pause : .play, for: .normal)
        isPlay ? player.play() : player.pause()
    }
    
    @objc func changePodcastItem(sender: UIButton) {
        player.removeTimeObserver(timeObserverToken as Any)
        if sender == forwardButton, indexPath.row < items.count{
            indexPath.row += 1
        } else if sender == backwardButton, indexPath.row > 0 {
            indexPath.row -= 1
        }
        updateUI()
    }
    
}

// MARK: UICollectionView Delegate and DataSource

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
                player.removeTimeObserver(timeObserverToken as Any)
                indexPath.row += 1
                updateUI()
            } else {
                playerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        } else if endOffset <= startOffset - increment {
            player.removeTimeObserver(timeObserverToken as Any)
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
