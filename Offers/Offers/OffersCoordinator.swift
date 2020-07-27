//
//  OffersCoordinator.swift
//  Offers
//
//  Created by Igor on 30.06.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import Core
import UI
import Models

public final class OffersCoordinator: BaseCoordinator {
    
    private weak var rootController: NavigationController?
    private let viewControllerFactory: ViewControllerFactory
    
    public init(rootController: NavigationController) {
        self.rootController = rootController
        self.viewControllerFactory = ViewControllerFactory()
        super.init()
    }
    
    public override func start() {
        rootController?.setNavigationBarHidden(true, animated: true)
        showListOfOffersController()
    }
    
    private func showListOfOffersController() {
        let controller = viewControllerFactory.makeListOfOffersController()
          
        controller.onOfferController = { [weak self] offer in
            self?.showOfferController(offer: offer)
        }
        
        rootController?.viewControllers = [controller]
    }
    
    private func showOfferController(offer: FakeOffer) {
        let controller = viewControllerFactory.makeOfferController()
        controller.offer = offer
        rootController?.pushViewController(controller, animated: true)
    }
    
    private func showError(error: Error) {
        print("Error \(error.localizedDescription)")
    }
}

