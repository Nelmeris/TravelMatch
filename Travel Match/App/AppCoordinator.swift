//
//  AppCoordinator.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import Core
import UI
import Auth
import OnBoarding

final class AppCoordinator: BaseCoordinator {
        
    private let viewControllerFactory: ViewControllerFactory
    private let onBoardingService: OnBoardingService
    private let authService: AuthService
    
    private var rootController: NavigationController!
    
    init(
        viewControllerFactory: ViewControllerFactory,
        onBoardingService: OnBoardingService,
        authService: AuthService
    ) {
        self.viewControllerFactory = viewControllerFactory
        self.onBoardingService = onBoardingService
        self.authService = authService
    }
    
    override func start() {
        rootController = viewControllerFactory.makeNavigationController()
        setAsRoot(rootController)
        
        if onBoardingService.shouldShow() {
            showOnBoarding()
            return
        }
        
        showAuth()
    }
    
    private func showOnBoarding() {
        let coordinator = OnBoardingCoordinator(
            rootController: rootController,
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
            rootController: rootController,
            authService: authService
        )
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
}
