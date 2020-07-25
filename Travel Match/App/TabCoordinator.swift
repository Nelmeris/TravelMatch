//
//  TabCoordinator.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 01.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import Core
import Offers

class TabCoordinator: BaseCoordinator {
    
    private weak var rootController: NavigationController?
        
    init(
        rootController: NavigationController
    ) {
        self.rootController = rootController
    }
    
    override func start() {
        let tabBarController = buildTabBarController()
        rootController?.present(tabBarController, animated: false, completion: nil)
        startOffersCoordinator(with: tabBarController.viewControllers![1])
    }
    
    private func startOffersCoordinator(with controller: UIViewController) {
        guard let controller = controller as? NavigationController else { fatalError() }
        let offersCoordinator = OffersCoordinator(rootController: controller)
        addDependency(offersCoordinator)
        offersCoordinator.start()
    }
    
    private func buildTabBarController() -> UITabBarController {
        let tabController = UITabBarController()
        tabController.modalPresentationStyle = .fullScreen
        tabController.setViewControllers([
            createNavigationController(imageName: "home", tag: 0),
            createNavigationController(imageName: "offers", tag: 1),
            createNavigationController(imageName: "impression", tag: 2),
            createNavigationController(imageName: "locals", tag: 3),
            createNavigationController(imageName: "profile", tag: 4)
        ], animated: false)
        return tabController
    }
    
    private func createNavigationController(imageName: String,
                                            tag: Int) -> NavigationController {
        let navController = NavigationController()
        navController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: imageName),
            tag: tag
        )
        return navController
    }

}
