//
//  OnBoardingSlide.swift
//  OnBoarding
//
//  Created by Artem Kufaev on 27.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

public protocol OnBoardingSlide {
    var image: UIImage { get }
    var title: String { get }
    var text: String { get }
}
