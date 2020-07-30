//
//  OffersCoordinator.swift
//  Offers
//
//  Created by Igor on 30.06.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI
import Core
import Pic
import Reviews


public final class OffersCoordinator: BaseCoordinator {
    
    private weak var rootController: NavigationController?
    private let viewControllerFactory: ViewControllerFactory
    private let mockFakeDataService: OffersService
    
    public init(rootController: NavigationController,
                mockFakeDataService: OffersService) {
        self.rootController = rootController
        self.viewControllerFactory = ViewControllerFactory()
        self.mockFakeDataService = mockFakeDataService
        super.init()
    }

    
    public override func start() {
        rootController?.setNavigationBarHidden(true, animated: true)
        showListOfOffersController()
    }
    
    private func showListOfOffersController() {
        let controller = viewControllerFactory.makeListOfOffersController()
        controller.mockFakeDataService = mockFakeDataService

        controller.onOfferController = { [weak self] offer in
            self?.showOfferController(offer: offer)
        }
        
        rootController?.viewControllers = [controller]
    }
    
    private func showOfferController(offer: Offer) {
        let controller = viewControllerFactory.makeOfferController()
        controller.offer = offer
        
        controller.onPicController = { [weak self] offerID, scrollToItem in
            self?.showPicController(offerID: offerID, scrollToItem: scrollToItem)
        }
        
        controller.onReviewsController = { [weak self] offerID in
            self?.showReviewsController(offerID: offerID)
        }
        
        if nil != rootController?.viewControllers.last as? ListOfOffersController {
            rootController?.pushViewController(controller, animated: true)
        } else {
            rootController?.pushViewController(controller, animated: true)
        }
    }
    
    private func showPicController(offerID: Int, scrollToItem: Int) {
        let picCoordinator = PicCoordinator(rootController: self.rootController!,
                                            offerID: offerID,
                                            scrollToItem: scrollToItem)
        picCoordinator.start()
        addDependency(picCoordinator)
    }
    
    private func showReviewsController(offerID: Int) {
        let reviewsCoordinator = ReviewsCoordinator(rootController: self.rootController!,
                                                offerID: offerID)
        reviewsCoordinator.start()
        addDependency(reviewsCoordinator)
    }
    
    private func showError(error: Error) {
        print("Error \(error.localizedDescription)")
    }
}

