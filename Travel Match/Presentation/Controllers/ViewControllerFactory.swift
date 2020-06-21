//
//  ViewControllerFactory.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 14.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

class ViewControllerFactory {
    
    func makeNavigationController() -> NavigationController {
        return NavigationController()
    }

    func makeOnBoardingController() -> OnBoardingViewController {
        return UIStoryboard(name: "OnBoarding", bundle: nil)
        .instantiateViewController(OnBoardingViewController.self)
    }
 
    func makeEmailController() -> EmailViewController {
        return UIStoryboard(name: "Email", bundle: nil)
        .instantiateViewController(EmailViewController.self)
    }
    
    func makePhoneController() -> PhoneViewController {
        return UIStoryboard(name: "Phone", bundle: nil)
        .instantiateViewController(PhoneViewController.self)
    }
    
    func makeSignUpController() -> SignUpViewController {
        return UIStoryboard(name: "SignUp", bundle: nil)
        .instantiateViewController(SignUpViewController.self)
    }

    func makeSignInController() -> SignInViewController {
        return UIStoryboard(name: "SignIn", bundle: nil)
        .instantiateViewController(SignInViewController.self)
    }

}
