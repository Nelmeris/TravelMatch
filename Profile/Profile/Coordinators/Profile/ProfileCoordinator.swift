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
    func presentNotifySettings()
    func setPushSetting(isOn: Bool)
    func setSmsSetting(isOn: Bool)
    func setEmailSetting(isOn: Bool)
}

public final class ProfileCoordinator: BaseCoordinator {
    
    private weak var rootController: NavigationController?
    private var profileService: ProfileService
    private var notifySettingsService: NotifySettingsService
    private var viewControllerFactory: ViewControllerFactory
    
    weak var controller: ProfileViewController?
    
    public init(rootController: NavigationController,
                profileService: ProfileService,
                notifySettingsService: NotifySettingsService) {
        self.rootController = rootController
        self.profileService = profileService
        self.notifySettingsService = notifySettingsService
        self.viewControllerFactory = ViewControllerFactory()
    }
    
    public override func start() {
        let vc = viewControllerFactory.makeProfileController()
        vc.coordinator = self
        vc.presenter = self
        vc.onLogoutButtonClicked = { [weak self] in
            vc.showActivityIndicator()
            self?.profileService.logout { (result) in
                vc.hideActivityIndicator()
                switch result {
                case .success: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        controller = vc
        rootController?.viewControllers = [vc]
    }
    
}

// MARK: - ProfileRoutingLogic

extension ProfileCoordinator: ProfileRoutingLogic {
    
    func toPersonalInfo() {
        let vc = viewControllerFactory.makePersonalInfoController()
        vc.title = "Личная информация"
        rootController?.pushViewController(vc, animated: true)
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

// MARK: - ProfileViewOutput

extension ProfileCoordinator: ProfileViewOutput {
    
    func presentProfileData() {
        let data = profileService.getProfileData()
        controller?.displayProfileData(data)
    }
    
    func setPushSetting(isOn: Bool) {
        notifySettingsService.setIsPushOn(isOn)
    }
    
    func setSmsSetting(isOn: Bool) {
        notifySettingsService.setIsSmsOn(isOn)
    }
    
    func setEmailSetting(isOn: Bool) {
        notifySettingsService.setIsEmailOn(isOn)
    }
    
    func presentNotifySettings() {
        controller?.displayNotifySettings(notifySettingsService.get())
    }
    
}
