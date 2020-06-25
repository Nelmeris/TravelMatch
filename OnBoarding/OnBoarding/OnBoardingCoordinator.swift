//
//  OnBoardingCoordinator.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import Core
import UI

public final class OnBoardingCoordinator: BaseCoordinator {
    
    private let viewControllerFactory: ViewControllerFactory
    private let onBoardingService: OnBoardingService
    
    private weak var rootController: NavigationController?
    
    public init(
        rootController: NavigationController,
        onBoardingService: OnBoardingService
    ) {
        self.rootController = rootController
        self.viewControllerFactory = ViewControllerFactory()
        self.onBoardingService = onBoardingService
    }
    
    public override func start() {
        let controller = viewControllerFactory.makeOnBoardingController()
        controller.slides = onBoardingService.getSlides()
        
        controller.onStartClicked = { [weak self] in
            self?.onFinishFlow?()
        }
        
        rootController?.viewControllers = [controller]
    }
    
}
