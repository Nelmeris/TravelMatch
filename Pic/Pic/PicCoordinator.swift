//
//  PicCoordinator.swift
//  Pic
//
//  Created by Igor on 21.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI
import Core


public final class OffersCoordinator: BaseCoordinator {
    
    private weak var rootController: NavigationController?
    private let reviewsControllerFactory: ViewControllerFactory
    
    public init(rootController: NavigationController) {
        self.rootController = rootController
        self.reviewsControllerFactory = ViewControllerFactory()
        super.init()
    }
    
    public override func start() {
        rootController?.setNavigationBarHidden(true, animated: true)
        showListOfOffersController()
    }
    
    private func showListOfOffersController() {
        let controller = reviewsControllerFactory.makePicController()
          
//        controller.onOfferController = { [weak self] offer in
//            self?.showOfferController(offer: offer)
//        }
        
        rootController?.viewControllers = [controller]
    }
    
    private func showError(error: Error) {
        print("Error \(error.localizedDescription)")
    }
}
