//
//  AuthCoordinator.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 14.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation

final class AuthCoordinator: BaseCoordinator {
    
    private let viewControllerFactory: ViewControllerFactory
    
    private var rootController: NavigationController!
    
    private var email: String?
    private var phone: String?
    
    init(
        viewControllerFactory: ViewControllerFactory
    ) {
        self.viewControllerFactory = viewControllerFactory
    }
    
    override func start() {
        rootController = viewControllerFactory.makeNavigationController()
        setAsRoot(rootController)
        showEmailLogin()
    }
    
    private func showEmailLogin() {
        let controller = viewControllerFactory.makeEmailController()
        
        controller.email = email
        
        controller.onPhoneModeClicked = { [weak self] in
            self?.showPhoneLogin()
        }
        
        controller.onContinueButtonClicked = { [weak self] email in
            self?.email = email
            self?.showSignUp()
        }
        
        rootController.viewControllers = [controller]
    }
    
    private func showPhoneLogin() {
        let controller = viewControllerFactory.makePhoneController()

        controller.phone = phone
        
        controller.onEmailModeClicked = { [weak self] in
            self?.showEmailLogin()
        }
        
        controller.onContinueButtonClicked = { [weak self] phone in
            self?.phone = phone
            self?.showSignIn()
        }
        
        rootController.viewControllers = [controller]
    }
    
    private func showSignUp() {
        let controller = viewControllerFactory.makeSignUpController()
        rootController.pushViewController(controller, animated: true)
    }

    private func showSignIn() {
        let controller = viewControllerFactory.makeSignInController()
        rootController.pushViewController(controller, animated: true)
    }
    
}
