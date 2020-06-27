//
//  AuthCoordinator.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 14.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import UIKit
import Core

public final class AuthCoordinator: BaseCoordinator {
    
    private weak var rootController: UINavigationController?
    private let viewControllerFactory: ViewControllerFactory
    private let authService: AuthService
    
    private var email: String?
    private var phone: String?
    
    public init(
        rootController: UINavigationController,
        authService: AuthService
    ) {
        self.rootController = rootController
        self.viewControllerFactory = ViewControllerFactory()
        self.authService = authService
        super.init()
    }
    
    public override func start() {
        showEmailLogin()
    }
    
    private func showEmailLogin() {
        let controller = viewControllerFactory.makeEmailController()
        
        controller.state = .initial(email)
        
        controller.onPhoneModeClicked = { [weak self] email in
            self?.email = email
            self?.showPhoneLogin()
        }
        
        controller.onContinueButtonClicked = { [weak self] email in
            self?.email = email
            self?.showSignUp()
        }
        
        rootController?.viewControllers = [controller]
    }
    
    private func showPhoneLogin() {
        let controller = viewControllerFactory.makePhoneController()

        controller.state = .initial(phone)
        
        controller.onEmailModeClicked = { [weak self] phone in
            self?.phone = phone
            self?.showEmailLogin()
        }
        
        controller.onContinueButtonClicked = { [weak self] phone in
            self?.phone = phone
            self?.showSignIn()
        }
        
        rootController?.viewControllers = [controller]
    }
    
    private func showSignUp() {
        let controller = viewControllerFactory.makeSignUpController()
        rootController?.pushViewController(controller, animated: true)
    }

    private func showSignIn() {
        let controller = viewControllerFactory.makeSignInController()
        
        controller.state = .initial(userName: "Константин")
        
        controller.onRecoverButtonClicked = { [weak self] in
            self?.showRecovery()
        }
        
        rootController?.pushViewController(controller, animated: true)
    }
    
    private func showRecovery() {
        guard let viewControllersStack = rootController?.viewControllers else { return }
       
        if viewControllersStack.contains(where: { $0 is EmailViewController }) {
            showRecoverByEmail()
            return
        }
        
        if viewControllersStack.contains(where: { $0 is PhoneViewController }) {
            showRecoverByPhone()
            return
        }

        showRecoverByEmail()
    }
    
    private func showRecoverByEmail() {
        let controller = viewControllerFactory.makeRecoverByEmailController()
        
        controller.state = .initial(email)
        
        controller.onPhoneModeClicked = { [weak self] in
            self?.showRecoverByPhone()
        }
        
        controller.onContinueButtonClicked = { [weak self] email in
            self?.email = email
        }
        
        if nil != rootController?.viewControllers.last as? RecoverByPhoneViewController {
            rootController?.popViewController(animated: false)
            rootController?.pushViewController(controller, animated: false)
        } else {
            rootController?.pushViewController(controller, animated: true)
        }
    }
    
    private func showRecoverByPhone() {
        let controller = viewControllerFactory.makeRecoverByPhoneController()
        
        controller.state = .initial(phone)
        
        controller.onEmailModeClicked = { [weak self] in
            self?.showRecoverByEmail()
        }
        
        controller.onContinueButtonClicked = { [weak self] phone in
            self?.phone = phone
        }
        
        if nil != rootController?.viewControllers.last as? RecoverByEmailViewController {
            rootController?.popViewController(animated: false)
            rootController?.pushViewController(controller, animated: false)
        } else {
            rootController?.pushViewController(controller, animated: true)
        }
    }
    
    private func showPasswordSent() {
        
    }
}
