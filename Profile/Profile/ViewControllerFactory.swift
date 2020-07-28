//
//  ViewControllerFactory.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

class ViewControllerFactory {
    
    func makeMainController() -> ProfileMainViewController {
        return ProfileMainViewController(
            nibName: String(describing: ProfileMainViewController.self),
            bundle: Bundle(for: ProfileMainViewController.self))
    }
    
}
