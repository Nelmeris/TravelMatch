//
//  AuthCoordinator.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 14.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import Core

public final class AuthCoordinator: BaseCoordinator {
    
    private weak var rootController: NavigationController?
    private let viewControllerFactory: ViewControllerFactory
    private let authService: AuthLogin & AuthSignUp & AuthSearch & AuthReset

    private var user: Authentificatable?
    private var email: String?
    private var phone: String?
    
    public init(
        rootController: NavigationController,
        authService: AuthLogin & AuthSignUp & AuthSearch & AuthReset
    ) {
        self.rootController = rootController
        self.viewControllerFactory = ViewControllerFactory()
        self.authService = authService
        super.init()
    }
    
    public override func start() {
        rootController?.setNavigationBarHidden(false, animated: true)
        showEmailLogin()
    }
    
    private func showEmailLogin() {
        let controller = viewControllerFactory.makeEmailController()
        
        controller.state = .initial(email)
        
        controller.onPhoneModeClicked = { [weak self] in
            self?.email = nil
            self?.showPhoneLogin()
        }
        
        controller.onGuestButtonClicked = { [weak self, weak controller] in
            controller?.state = .loading
            self?.authService.loginGuest(completion: { (result) in
                switch result {
                case .success:
                    self?.onFinishFlow?()
                case .failure(let error):
                    self?.showError(error: error)
                }
            })
        }
        
        controller.onContinueButtonClicked = { [weak self, weak controller] email in
            self?.email = email
            
            controller?.state = .loading
            
            self?.authService.searchUser(
                byEmail: email
            ) { (result) in
                switch result {
                case .success(let user):
                    self?.user = user
                    controller?.state = .initial(email)
                    if user != nil {
                        self?.showSignIn()
                    } else {
                        self?.showSignUp()
                    }
                case .failure(let error):
                    controller?.state = .error(error.localizedDescription)
                }
            }
        }
        
        rootController?.viewControllers = [controller]
    }
    
    private func showPhoneLogin() {
        let controller = viewControllerFactory.makePhoneController()
        
        controller.state = .initial(phone)
        
        controller.onEmailModeClicked = { [weak self] in
            self?.phone = nil
            self?.showEmailLogin()
        }
        
        controller.onGuestButtonClicked = { [weak self, weak controller] in
            controller?.state = .loading
            self?.authService.loginGuest(completion: { (result) in
                switch result {
                case .success:
                    self?.onFinishFlow?()
                case .failure(let error):
                    self?.showError(error: error)
                }
            })
        }
        
        controller.onContinueButtonClicked = { [weak self, weak controller] phone in
            self?.phone = phone
            controller?.state = .loading
            self?.authService.searchUser(
                byPhone: phone
            ) { (result) in
                switch result {
                case .success(let user):
                    self?.user = user
                    controller?.state = .initial(phone)
                    if user != nil {
                        self?.showSignIn()
                    } else {
                        self?.showSignUp()
                    }
                case .failure(let error):
                    controller?.state = .error(error.localizedDescription)
                }
            }
        }
        
        rootController?.viewControllers = [controller]
    }
    
    private func showSignUp() {
        let controller = viewControllerFactory.makeSignUpController()
        controller.state = .initial
        
        controller.onContinueButtonClicked = { [weak self, weak controller] name, password in
            
            controller?.state = .loading
            
            if let email = self?.email {
                self?.authService.signUp(
                    email: email,
                    password: password,
                    name: name,
                    completion: { (result) in
                        switch result {
                        case .success:
                            self?.onFinishFlow?()
                        case .failure(let error):
                            controller?.state = .error(error.localizedDescription)
                        }
                })
                return
            }

            if let phone = self?.phone {
                self?.authService.signUp(
                    phone: phone,
                    password: password,
                    name: name,
                    completion: { (result) in
                        switch result {
                        case .success:
                            self?.onFinishFlow?()
                        case .failure(let error):
                            controller?.state = .error(error.localizedDescription)
                        }
                })
                return
            }
            
        }
        
        rootController?.pushViewController(controller, animated: true)
    }

    private func showSignIn() {
        guard let user = user else {
            showSignUp()
            return
        }
        
        let controller = viewControllerFactory.makeSignInController()
        
        controller.state = .initial(userName: user.name)
        
        controller.onContinueButtonClicked = { [weak self, weak controller] password, remember in
            controller?.state = .loading
            self?.authService.login(
                userId: user.id,
                password: password,
                remember: remember,
                completion: { (result) in
                    switch result {
                    case .success:
                        self?.onFinishFlow?()
                    case .failure(let error):
                        controller?.state = .error(error: error.localizedDescription)
                    }
            })
        }
        
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
        
        controller.onContinueButtonClicked = { [weak self, weak controller] email in
            self?.email = email
            controller?.state = .loading
            self?.authService.resetPassword(email: email, completion: { (result) in
                controller?.state = .initial(email)
                switch result {
                case .success:
                    self?.showPasswordSent()
                case .failure(let error):
                    controller?.state = .error(error.localizedDescription)
                }
            })
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
        
        controller.onContinueButtonClicked = { [weak self, weak controller] phone in
            self?.phone = phone
            controller?.state = .loading
            self?.authService.resetPassword(phone: phone, completion: { (result) in
                controller?.state = .initial(phone)
                switch result {
                case .success:
                    self?.showPasswordSent()
                case .failure(let error):
                    controller?.state = .error(error.localizedDescription)
                }
            })
        }
        
        if nil != rootController?.viewControllers.last as? RecoverByEmailViewController {
            rootController?.popViewController(animated: false)
            rootController?.pushViewController(controller, animated: false)
        } else {
            rootController?.pushViewController(controller, animated: true)
        }
    }
    
    private func showPasswordSent() {
        let controller = viewControllerFactory.makePasswordSentController()
        
        if let email = email {
            controller.message = "Мы отправили тебе новый пароль. Проверь почту \(email)"
        } else if let phone = phone {
            controller.message = "Мы отправили тебе новый пароль \nна телефон \(phone)"
        }
        
        controller.onLoginButtonClicked = { [weak self, weak controller] in
            
            controller?.dismiss(animated: true, completion: nil)
            
            if self?.phone != nil {
                self?.showPhoneLogin()
            } else {
                self?.showEmailLogin()
            }
        }
        
        controller.modalPresentationStyle = .fullScreen
        rootController?.present(controller, animated: true, completion: nil)
    }
    
    private func showError(error: Error) {
        print("Error \(error.localizedDescription)")
    }
}
