//
//  ProfileAssembley.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

final class ProfileAssembley {
    
    static func assembleProfileController(for coordinator: ProfileRoutingLogic,
                                          profileService: ProfileService) -> ProfileViewController {
        let controller = ViewControllerFactory().makeController()
        let presenter = ProfilePresenter()
        controller.presenter = presenter
        presenter.controller = controller
        presenter.coordinator = coordinator
        presenter.profileService = profileService
        return controller
    }
    
}
