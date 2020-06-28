//
//  NavigationController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 17.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

public class NavigationController: UINavigationController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBackButton()
    }
    
    private func setupBackButton() {
        navigationBar.backIndicatorImage = UIImage(named: "backButton")
        navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")        
    }
    
    private func setupNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = true
    }
        
}
