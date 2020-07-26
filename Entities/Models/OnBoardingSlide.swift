//
//  OnBoardingSlide.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

public struct OnBoardingSlide {
    public let image: UIImage
    public let title: String
    public let text: String
    
    public init(image: UIImage,
                title: String,
                text: String) {
        self.image = image
        self.title = title
        self.text = text
    }
}
