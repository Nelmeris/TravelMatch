//
//  ProfileMainCoordinator.swift
//  Profile
//
//  Created by Artem Kufaev on 27.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Core

protocol ProfileMainRoutingLogic {
    
}

public final class ProfileMainCoordinator: BaseCoordinator {
    
    private weak var rootController: NavigationController?
    
    weak var controller: ProfileMainViewController?
    
    public init(with rootController: NavigationController) {
        self.rootController = rootController
    }
    
    public override func start() {
        let vc = ProfileMainAssembler.assembleMainController(for: self)
        rootController?.viewControllers = [vc]
    }
    
}

extension ProfileMainCoordinator: ProfileMainRoutingLogic {
    
}
