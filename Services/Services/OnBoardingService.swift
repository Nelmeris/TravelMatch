//
//  OnBoardingService.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import OnBoarding
import Models

public final class UserDefaultsOnBoardingService: OnBoardingService {
        
    private let userDefaults: UserDefaults
    
    public init(
        userDefaults: UserDefaults
    ) {
        self.userDefaults = userDefaults
    }
    
    public func shouldShow() -> Bool {
        return !userDefaults.bool(forKey: .onBoardingShown)
    }
    
    public func wasShown() {
        userDefaults.set(true, forKey: .onBoardingShown)
    }
    
    public func getSlides() -> [OnBoardingSlide] {
        return [
            OnBoardingSlide(
                image: UIImage(named: "onboarding1")!,
                title: "Исследуй новое",
                text: "Местные жители помогут сделать твоё путешествие незабываемым"
            ),
            OnBoardingSlide(
                image: UIImage(named: "onboarding2")!,
                title: "Планируй досуг",
                text: "Выбирай из тысяч предложений или запланируй уникальное"
            ),
            OnBoardingSlide(
                image: UIImage(named: "onboarding3")!,
                title: "Делись эмоциями",
                text: "Наслаждайся своим путешествием. Не забудь поделиться эмоциями"
            )
        ]
    }
    
}
