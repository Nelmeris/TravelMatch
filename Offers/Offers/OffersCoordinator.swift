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
        let controller = reviewsControllerFactory.makeListOfOffersController()
          
        controller.onOfferController = { [weak self] offer in
            self?.showOfferController(offer: offer)
        }
        
        rootController?.viewControllers = [controller]
    }
    
    private func showOfferController(offer: FakeOffer) {
        let controller = reviewsControllerFactory.makeOfferController()
        controller.offer = offer
        
        controller.onPicController = { [weak self] images, scrollToItem in
            self?.showPicController(images: images, scrollToItem: scrollToItem)
        }
        
        controller.onReviewsController = { [weak self] offerID, hideSendReviewView in
            self?.showReviewsController(offerID: offerID, hideSendReviewView: hideSendReviewView)
        }
        
        if nil != rootController?.viewControllers.last as? ListOfOffersController {
            rootController?.pushViewController(controller, animated: true)
        } else {
            rootController?.pushViewController(controller, animated: true)
        }
    }
    
    private func showPicController(images: [UIImage], scrollToItem: Int) {
        let controller = reviewsControllerFactory.makePicController()
        controller.images = images
        controller.scrollToItem = scrollToItem
        
        controller.didPressedCloseButton = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        
        if nil != rootController?.viewControllers.last as? OfferController {
            rootController?.pushViewController(controller, animated: true)
        } else {
            rootController?.pushViewController(controller, animated: true)
        }
    }
    
    private func showReviewsController(offerID: Int, hideSendReviewView: Bool) {
        let controller = reviewsControllerFactory.makeReviewsController()
        controller.offerID = offerID
        controller.isHiddenSendReviewView = hideSendReviewView
        
        controller.didPressedCloseButton = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        
        if nil != rootController?.viewControllers.last as? OfferController {
            rootController?.pushViewController(controller, animated: true)
        } else {
            rootController?.pushViewController(controller, animated: true)
        }
    }
    
    private func showError(error: Error) {
        print("Error \(error.localizedDescription)")
    }
}

