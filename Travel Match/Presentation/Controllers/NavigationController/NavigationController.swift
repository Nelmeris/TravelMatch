//
//  NavigationController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 17.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBackButton()
    }
    
    private func setupBackButton() {
        navigationBar.backIndicatorImage = UIImage(named: "backButton")
        navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        navigationBar.tintColor = UIColor.ThemeColors.textColor
    }
    
    private func setupNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = true
    }
        
}
