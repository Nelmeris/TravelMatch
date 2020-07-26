//
//  OnBoardingService.swift
//  OnBoarding
//
//  Created by Maxim Timokhin on 25.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Models

public protocol OnBoardingService {
    func shouldShow() -> Bool
    func wasShown()
    func getSlides() -> [OnBoardingSlide]
}
