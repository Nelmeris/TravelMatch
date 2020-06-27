//
//  AppCoordinator.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import Core
import Auth
import OnBoarding
// import Questions

final class AppCoordinator: BaseCoordinator {
        
    private let onBoardingService: OnBoardingService
    private let authService: AuthService
    
    private var rootController: UINavigationController!
    
    init(
        onBoardingService: OnBoardingService,
        authService: AuthService
    ) {
        self.onBoardingService = onBoardingService
        self.authService = authService
    }
    
    override func start() {
        rootController = UINavigationController()
        rootController.setNavigationBarHidden(true, animated: false)
        setAsRoot(rootController)
        
        if onBoardingService.shouldShow() {
            showOnBoarding()
            return
        }
        
        if !authService.isAuthorized() {
            showAuth()
            return
        }
        
        // showQuestions()
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
    
//    private func showQuestions() {
//        let coordinator = QuestionsCoordinator(
//            rootController: rootController
//        )
//        coordinator.onFinishFlow = { [weak self, weak coordinator] in
//            self?.removeDependency(coordinator)
//            self?.start()
//        }
//        addDependency(coordinator)
//        coordinator.start()
//    }
//
}
