//
//  ProfileMainPresenter.swift
//  Profile
//
//  Created by Artem Kufaev on 27.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

protocol ProfileMainPresentationLogic {
    func presentMenuItems()
}

class ProfileMainPresenter {
    
    weak var controller: ProfileMainDisplayLogic?
    
}

extension ProfileMainPresenter: ProfileMainPresentationLogic {
    
    func presentMenuItems() {
        
    }
    
}
