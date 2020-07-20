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
        
       /* controller.onPicController = { [weak self] images, scrollToItem in
            self?.showPicController(images: images, scrollToItem: scrollToItem)
        }*/
        
        if nil != rootController?.viewControllers.last as? ListOfOffersController {
            rootController?.pushViewController(controller, animated: true)
        } else {
            rootController?.pushViewController(controller, animated: true)
        }
    }
    /*
    private func showPicController(images: [UIImage], scrollToItem: Int) {
        let controller = viewControllerFactory.makePicController()
        controller.images = images
        controller.scrollToItem = scrollToItem
        
        if nil != rootController?.viewControllers.last as? OfferController {
            rootController?.pushViewController(controller, animated: true)
        } else {
            rootController?.pushViewController(controller, animated: true)
        }
    }
    
    private func showReviewsController(images: [UIImage], scrollToItem: Int) {
        let controller = viewControllerFactory.makeReviewsController()
        
        
        if nil != rootController?.viewControllers.last as? OfferController {
            rootController?.pushViewController(controller, animated: true)
        } else {
            rootController?.pushViewController(controller, animated: true)
        }
    }*/
    
    private func showError(error: Error) {
        print("Error \(error.localizedDescription)")
    }
}

