//
//  ProfileMainViewController.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

protocol ProfileMainDisplayLogic: class {
    func displayMenuItems()
}

class ProfileMainViewController: UIViewController {
    
    var presenter: ProfileMainPresentationLogic?
    var coordinator: ProfileMainRoutingLogic?

}

extension ProfileMainViewController: ProfileMainDisplayLogic {
    
    func displayMenuItems() {
        
    }
    
}
