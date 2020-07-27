//
//  OnBoardingViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class OnBoardingViewController: UIViewController {
    
    //MARK: - Input
    
    var slides: [OnBoardingSlide]!
    
    // MARK: - Output
    
    var onStartClicked: (() -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageWrapView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var textWrapView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: Label!

    var currentIndex = 0 {
        didSet {
            showSlide(at: currentIndex)
        }
    }
    var timer: Timer?
    var transitionDuration: Double = 3.0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showSlide(at: 0)
        startPlaying()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopPlaying()
    }
    
    // MARK: - Playback
    
    private func showSlide(at index: Int) {
        let slide = slides[index]
        
        imageWrapView.alpha = 0
        textWrapView.alpha = 0
        imageView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            .translatedBy(x: 5.0, y: 5.0)
        
        imageView.image = slide.image
        titleLabel.text = slide.title
        textLabel.text = slide.text
        
        let fadeDuration = transitionDuration / 5
        let moveDuration = transitionDuration * 2
        
        UIView.animate(withDuration: fadeDuration, delay: 0.2, options: .curveEaseInOut, animations: {
            self.imageWrapView.alpha = 1
            self.textWrapView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: moveDuration, delay: 0.0, options: .curveEaseInOut, animations: {
            self.imageView.transform = .identity
        }, completion: nil)
        
    }
    
    private func startPlaying() {
        guard timer == nil else {return}
        
        let timer = Timer(timeInterval: transitionDuration,
                          target: self,
                          selector: #selector(timerAction),
                          userInfo: nil,
                          repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
        
        self.timer = timer
    }
    
    private func stopPlaying() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Actions
    
    @objc func timerAction() {
        currentIndex = currentIndex >= slides.count - 1
            ? 0
            : currentIndex + 1
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        onStartClicked?()
    }    
    
}
