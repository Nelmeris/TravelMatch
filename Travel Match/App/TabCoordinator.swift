//
//  TabCoordinator.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 01.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import Core
import Locals
import Offers

class TabCoordinator: BaseCoordinator {
    
    private weak var rootController: NavigationController?

    private let localsService: LocalsService

    init(
        rootController: NavigationController,
        localsService: LocalsService
    ) {
        self.rootController = rootController
        self.localsService = localsService
    }
    
    override func start() {
        let tabController = UITabBarController()
        
        let homeNavContrller = NavigationController()
        homeNavContrller.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "home"),
            tag: 0
        )

        let offersNavContrller = NavigationController()
        offersNavContrller.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "offers"),
            tag: 1
        )

        let impressionsNavContrller = NavigationController()
        impressionsNavContrller.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "impression"),
            tag: 2
        )

        let localsNavContrller = NavigationController()
        localsNavContrller.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "locals"),
            tag: 3
        )

        let profileNavContrller = NavigationController()
        profileNavContrller.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "profile"),
            tag: 4
        )
        
        tabController.viewControllers = [
            homeNavContrller,
            offersNavContrller,
            impressionsNavContrller,
            localsNavContrller,
            profileNavContrller
        ]

        let localsCoordinator = LocalsCoordinator(
            rootController: localsNavContrller,
            localsService: localsService
        )
        addDependency(localsCoordinator)
        localsCoordinator.start()

        tabController.selectedIndex = 3

        tabController.modalPresentationStyle = .fullScreen
        rootController?.present(tabController, animated: false, completion: nil)

        let offersCoordinator = OffersCoordinator(rootController: offersNavContrller)
        addDependency(offersCoordinator)
        offersCoordinator.start()

    }

}
