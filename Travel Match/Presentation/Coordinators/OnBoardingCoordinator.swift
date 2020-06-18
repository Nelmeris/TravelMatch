//
//  OnBoardingCoordinator.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import UIKit

final class OnBoardingCoordinator: BaseCoordinator {
    
    private let viewControllerFactory: ViewControllerFactory
    private let onBoardingService: OnBoardingService
    
    init(
        viewControllerFactory: ViewControllerFactory,
        onBoardingService: OnBoardingService
    ) {
        self.viewControllerFactory = viewControllerFactory
        self.onBoardingService = onBoardingService
    }
    
    override func start() {
        let controller = viewControllerFactory.makeOnBoardingController()
        controller.slides = onBoardingService.getSlides()
        
        controller.onStartClicked = { [weak self] in
            self?.onFinishFlow?()
        }
        
        setAsRoot(controller)        
    }
    
}
