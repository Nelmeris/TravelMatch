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
    func toPersonalInfo()
    func toAchievements()
    func toRequisites()
    func toMessages()
    func toFavourites()
    func toBookings()
    func toOffers()
    func toLocal()
    func toBookingRequests()
    func toSupportChat()
}

protocol ProfileViewOutput {
    func presentProfileData()
}

public final class ProfileCoordinator: BaseCoordinator {
    
    private weak var rootController: NavigationController?
    private var profileService: ProfileService
    private var viewControllerFactory: ViewControllerFactory
    
    weak var controller: ProfileViewController?
    
    public init(rootController: NavigationController,
                profileService: ProfileService) {
        self.rootController = rootController
        self.profileService = profileService
        self.viewControllerFactory = ViewControllerFactory()
    }
    
    public override func start() {
        let vc = viewControllerFactory.makeController()
        vc.coordinator = self
        vc.presenter = self
        controller = vc
        rootController?.viewControllers = [vc]
    }
    
}

extension ProfileCoordinator: ProfileRoutingLogic {
    
    func toPersonalInfo() {
        print("TO PERSONAL INFO")
    }
    
    func toAchievements() {
        print("TO ACHIEVEMENTS")
    }
    
    func toRequisites() {
        print("TO REQUISITES")
    }
    
    func toMessages() {
        print("TO MESSAGES")
    }
    
    func toFavourites() {
        print("TO FAVOURITES")
    }
    
    func toBookings() {
        print("TO BOOKINGS")
    }
    
    func toOffers() {
        print("TO OFFERS")
    }
    
    func toLocal() {
        print("TO LOCAL")
    }
    
    func toBookingRequests() {
        print("TO BOOKING REQUESTS")
    }
    
    func toSupportChat() {
        print("TO SUPPORT CHAT")
    }
    
}

extension ProfileCoordinator: ProfileViewOutput {
    
    func presentProfileData() {
        let data = profileService.getProfileData()
        controller?.displayProfileData(data)
    }
    
}
