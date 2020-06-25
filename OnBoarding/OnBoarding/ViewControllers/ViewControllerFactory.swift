//
//  ViewControllerFactory.swift
//  OnBoarding
//
//  Created by Maxim Timokhin on 25.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class ViewControllerFactory {
    
    func makeOnBoardingController() -> OnBoardingViewController {
        return UIStoryboard(name: "OnBoarding", bundle: Bundle(for: OnBoardingViewController.self))
        .instantiateViewController(OnBoardingViewController.self)
    }
    
}
