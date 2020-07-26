//
//  AppCoordinator.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Core
import Auth
import OnBoarding
import Questions
import Locals
import Services

final class AppCoordinator: BaseCoordinator {
        
    private let onBoardingService: OnBoardingService
    private let authService: AuthService
    private let questionsService: QuestionsService
    private let localsService: LocalsService

    private var rootController: NavigationController!
    
    init(
        onBoardingService: OnBoardingService,
        authService: AuthService,
        questionsService: QuestionsService,
        localsService: LocalsService
    ) {
        self.onBoardingService = onBoardingService
        self.authService = authService
        self.questionsService = questionsService
        self.localsService = localsService
    }
    
    override func start() {
        rootController = NavigationController()
        rootController.setNavigationBarHidden(true, animated: false)
        setAsRoot(rootController)
        
        if onBoardingService.shouldShow() {
            showOnBoarding()
            return
        }
        
        if !authService.isAuthorized {
            showAuth()
            return
        }
        
        if questionsService.shouldShowQuestion {
            showQuestions()
            return
        }
        
        showMain()
    }
    
    // MARK: - Onboarding
    
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
    
    // MARK: - Authorization
    
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
    
    // MARK: - Questions
    
    private func showQuestions() {
        let coordinator = QuestionsCoordinator(
            rootController: rootController,
            questionsService: questionsService
        )
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    // MARK: - Main tabbar
    
    private func showMain() {
        let coordinator = TabCoordinator(
            rootController: rootController,
            localsService: localsService
        )
        
        addDependency(coordinator)
        coordinator.start()
    }

}
