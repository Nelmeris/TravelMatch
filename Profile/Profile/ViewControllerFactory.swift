//
//  ViewControllerFactory.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

class ViewControllerFactory {
    
    func makeController() -> ProfileViewController {
        return ProfileViewController(
            nibName: String(describing: ProfileViewController.self),
            bundle: Bundle(for: ProfileViewController.self))
    }
    
}
