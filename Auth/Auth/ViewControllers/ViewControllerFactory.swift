//
//  ViewControllerFactory.swift
//  Auth
//
//  Created by Maxim Timokhin on 14.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class ViewControllerFactory {
    
    func makeEmailController() -> EmailViewController {
        return UIStoryboard(name: "Auth", bundle: Bundle(for: EmailViewController.self))
        .instantiateViewController(EmailViewController.self)
    }
    
    func makePhoneController() -> PhoneViewController {
        return UIStoryboard(name: "Auth", bundle: Bundle(for: PhoneViewController.self))
        .instantiateViewController(PhoneViewController.self)
    }
    
    func makeSignUpController() -> SignUpViewController {
        return UIStoryboard(name: "Auth", bundle: Bundle(for: SignUpViewController.self))
        .instantiateViewController(SignUpViewController.self)
    }

    func makeSignInController() -> SignInViewController {
        return UIStoryboard(name: "Auth", bundle: Bundle(for: SignInViewController.self))
        .instantiateViewController(SignInViewController.self)
    }
    
    func makeRecoverByEmailController() -> RecoverByEmailViewController {
        return UIStoryboard(name: "Auth", bundle: Bundle(for: RecoverByEmailViewController.self))
        .instantiateViewController(RecoverByEmailViewController.self)
    }
    
    func makeRecoverByPhoneController() -> RecoverByPhoneViewController {
        return UIStoryboard(name: "Auth", bundle: Bundle(for: RecoverByPhoneViewController.self))
        .instantiateViewController(RecoverByPhoneViewController.self)
    }
}
