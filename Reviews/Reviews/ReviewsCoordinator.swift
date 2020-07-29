//
//  ReviewsCoordinator.swift
//  Reviews
//
//  Created by Igor on 24.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI
import Core

public final class ReviewsCoordinator: BaseCoordinator {
    
    private weak var rootController: NavigationController?
    private var offerID: Int?
    private var impressionID: Int?
    private let reviewsControllerFactory: ViewControllerFactory
    
    public init(rootController: NavigationController, offerID: Int) {
        self.rootController = rootController
        self.offerID = offerID
        self.reviewsControllerFactory = ViewControllerFactory()
        super.init()
    }
    
    public init(rootController: NavigationController, impressionID: Int) {
        self.rootController = rootController
        self.impressionID = impressionID
        self.reviewsControllerFactory = ViewControllerFactory()
        super.init()
    }
    
    public override func start() {
        rootController?.setNavigationBarHidden(true, animated: true)
        showReviewsController()
    }
    
    private func showReviewsController() {
        let controller = reviewsControllerFactory.makeReviewController()
        if let offerID = offerID {
            controller.offerID = offerID
            controller.isHiddenSendReviewView = true
        } else if let impressionID = impressionID {
            controller.impressionID = impressionID
            controller.isHiddenSendReviewView = false
        }
                  
        controller.didPressedCloseButton = { [weak self] in
            self?.rootController?.popViewController(animated: true) /// not working
            controller.navigationController?.popViewController(animated: true) ///work
        }
        
        rootController?.pushViewController(controller, animated: true)
    }
    
    private func showError(error: Error) {
        print("Error \(error.localizedDescription)")
    }
}
