//
//  OffersCoordinator.swift
//  Offers
//
//  Created by Igor on 30.06.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import Core
import UI

public final class OffersCoordinator: BaseCoordinator {
    
    private weak var rootController: NavigationController?
    private let viewControllerFactory: ViewControllerFactory
    
    public init(rootController: NavigationController) {
        self.rootController = rootController
        self.viewControllerFactory = ViewControllerFactory()
        super.init()
    }
    
    public override func start() {
        rootController?.setNavigationBarHidden(true, animated: true)
        showListOfOffersController()
    }
    
    private func showListOfOffersController() {
        let controller = viewControllerFactory.makeListOfOffersController()
          /*
        controller.onGuestButtonClicked = { [weak self, weak controller] in
            controller?.state = .loading
            self?.authService.signInGuest(completion: { (result) in
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
        */
        rootController?.viewControllers = [controller]
    }
    /*
    private func showPhoneLogin() {
        let controller = viewControllerFactory.makePhoneController()
        
        controller.state = .initial(phone)
        
        controller.onEmailModeClicked = { [weak self] in
            self?.phone = nil
            self?.showEmailLogin()
        }
        
        controller.onGuestButtonClicked = { [weak self, weak controller] in
            controller?.state = .loading
            self?.authService.signInGuest(completion: { (result) in
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
            self?.authService.signIn(
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
            self?.authService.resetPasssword(email: email, completion: { (result) in
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
            self?.authService.resetPasssword(phone: phone, completion: { (result) in
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
    }*/
    
    private func showOfferController() {
        let controller = viewControllerFactory.makeOfferController()
        /*
        controller.onLoginButtonClicked = { [weak self, weak controller] in
            
            controller?.dismiss(animated: true, completion: nil)
            
            if self?.phone != nil {
                self?.showPhoneLogin()
            } else {
                self?.showEmailLogin()
            }
        }
        */
        controller.modalPresentationStyle = .fullScreen
        rootController?.present(controller, animated: true, completion: nil)
    }
    
    private func showError(error: Error) {
        print("Error \(error.localizedDescription)")
    }
}

