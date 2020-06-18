//
//  AppCoordinator.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation

final class AppCoordinator: BaseCoordinator {
        
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
        if onBoardingService.shouldShow() {
            showOnBoarding()
            return
        }
        
        showAuth()
    }
    
    private func showOnBoarding() {
        let coordinator = OnBoardingCoordinator(
            viewControllerFactory: viewControllerFactory,
            onBoardingService: onBoardingService
        )
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.onBoardingService.wasShown()
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func showAuth() {
        let coordinator = AuthCoordinator(
            viewControllerFactory: viewControllerFactory
        )
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
}
