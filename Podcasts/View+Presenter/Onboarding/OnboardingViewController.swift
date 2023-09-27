//
//  OnboardingViewController.swift
//  Podcasts
//
//  Created by Alexander Altman on 27.09.2023.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    //MARK: - Elements
    private let firstOnboardingScreen = OnboardingScreens()
    private let secondOnboardingScreen = OnboardingScreens()
    private let thirdOnboardingScreen = OnboardingScreens()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.contentInsetAdjustmentBehavior = .scrollableAxes
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "obBack01")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.preferredIndicatorImage = UIImage(named: "inactivePageIndicator")
        pageControl.pageIndicatorTintColor = .seaBlue
        pageControl.currentPageIndicatorTintColor = .peachPink
        pageControl.addTarget(self, action: #selector(pageControlIndicatorTapped(sender:)), for: .valueChanged)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private var slides = [OnboardingScreens]()
    
    //MARK: - Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        slides = createSlides()
        setupSlidesScrollView(slides: slides)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrints()
        setDelegates()
        buttonsTapped()
    }
    
    //MARK: - Private Methods
    @objc private func pageControlIndicatorTapped(sender: UIPageControl) {
        let offsetX = view.bounds.width * CGFloat(pageControl.currentPage)
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    private func setupViews() {
        view.backgroundColor = .red
        navigationController?.isNavigationBarHidden = true
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundImageView)
        view.addSubview(pageControl)
    }
    
    private func setDelegates() {
        scrollView.delegate = self
    }
    
    private func makeText(text1: String, text2: String) -> NSAttributedString {
        var orangeAttribute = [NSAttributedString.Key: AnyObject]()
        orangeAttribute[.foregroundColor] = UIColor.peachPink
        
        var whiteAttribute = [NSAttributedString.Key: AnyObject]()
        whiteAttribute[.foregroundColor] = UIColor.white
        
        let text = NSMutableAttributedString(string: text1, attributes: whiteAttribute)
        text.append(NSAttributedString(string: text2, attributes: orangeAttribute))
        
        return text
    }
    
    private func createSlides() -> [OnboardingScreens] {
        firstOnboardingScreen.setPageLabelText(text: makeText(text1: "Dozens of podcasts from ", text2: "all over the world!"))
        firstOnboardingScreen.hideContinueButton()
        
        secondOnboardingScreen.setPageLabelText(text: makeText(text1: "Listen online or ", text2: "save it for later"))
        secondOnboardingScreen.hideContinueButton()
        
        thirdOnboardingScreen.setPageLabelText(text: makeText(text1: "From boring news to ", text2: "great music shows"))
        thirdOnboardingScreen.hideSkipButton()
        
        return [firstOnboardingScreen, secondOnboardingScreen, thirdOnboardingScreen]
    }
    
    private func setupSlidesScrollView(slides: [OnboardingScreens]) {
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count),
                                        height: view.frame.height)
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i),
                                     y: 0,
                                     width: view.frame.width,
                                     height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func buttonsTapped() {
        firstOnboardingScreen.skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        secondOnboardingScreen.skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        thirdOnboardingScreen.continueButton.addTarget(self, action: #selector(continueButtonTapped(_:)), for: .primaryActionTriggered)
    }
    
    //FIXME: change distanation once main VC will be ready
    @objc func skipButtonTapped() {
        let vc = ViewController() // go to main VC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true) //!!!: delete this line and line above once navigation controller will be enabled
//        navigationController?.pushViewController(vc, animated: true) //!!!: uncomment once navigation controller will be enabled
    }
    //FIXME: change distanation once main VC will be ready
    @objc func continueButtonTapped(_ sender: UIButton) {
        let vc = ViewController() // go to main VC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true) //!!!: delete this line and line above once navigation controller will be enabled
        
//        navigationController?.pushViewController(vc, animated: true) //!!!: uncomment once navigation controller will be enabled
    }
}

//MARK: - UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate, UIPageViewControllerDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maxHOffset = scrollView.contentSize.width - view.frame.width
        let percentHOffset = scrollView.contentOffset.x / maxHOffset
        
        if percentHOffset <= 0.5 {
            let firstTransformation = CGAffineTransform(scaleX: (0.5 - percentHOffset) / 0.5,
                                                        y: (0.5 - percentHOffset) / 0.5)
            let secondTransformation = CGAffineTransform(scaleX: percentHOffset / 0.5,
                                                         y: percentHOffset / 0.5)
            slides[0].setPageLabelTransformWith(transform: firstTransformation)
            slides[1].setPageLabelTransformWith(transform: secondTransformation)
        } else {
            let secondTransformation = CGAffineTransform(scaleX: (1 - percentHOffset) / 0.5,
                                                         y: (1 - percentHOffset) / 0.5)
            let thirdTransformation = CGAffineTransform(scaleX: percentHOffset,
                                                        y: percentHOffset)
            slides[1].setPageLabelTransformWith(transform: secondTransformation)
            slides[2].setPageLabelTransformWith(transform: thirdTransformation)
        }
    }
}

//MARK: - Set Constraints
extension OnboardingViewController {
    private func setConstrints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            pageControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

