//
//  ProfileCoordinator.swift
//  Profile
//
//  Created by Artem Kufaev on 27.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Core
import UIKit

protocol ProfileRoutingLogic {
    func toController(_ controller: UIViewController)
}

public final class ProfileCoordinator: BaseCoordinator {
    
    private weak var rootController: NavigationController?
    private var profileService: ProfileService
    
    weak var controller: ProfileViewController?
    
    public init(rootController: NavigationController,
                profileService: ProfileService) {
        self.rootController = rootController
        self.profileService = profileService
    }
    
    public override func start() {
        let vc = ProfileAssembley.assembleProfileController(for: self,
                                                            profileService: profileService)
        rootController?.viewControllers = [vc]
    }
    
}

extension ProfileCoordinator: ProfileRoutingLogic {
    
    func toController(_ controller: UIViewController) {
        rootController?.pushViewController(controller, animated: true)
    }
    
}
