//
//  ProfileMainAssembler.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

final class ProfileMainAssembler {
    
    static func assembleMainController(for coordinator: ProfileMainRoutingLogic) -> ProfileMainViewController {
        let controller = ViewControllerFactory().makeMainController()
        let presenter = ProfileMainPresenter()
        controller.coordinator = coordinator
        controller.presenter = presenter
        presenter.controller = controller
        return controller
    }
    
}
