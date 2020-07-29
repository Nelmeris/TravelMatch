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

public final class PicCoordinator: BaseCoordinator {
    
    private weak var rootController: NavigationController?
    private var offerID: Int?
    private var impressionID: Int?
    private var scrollToItem: Int = 0
    private let picControllerFactory: ViewControllerFactory
    
    public init(rootController: NavigationController, offerID: Int, scrollToItem: Int) {
        self.rootController = rootController
        self.offerID = offerID
        self.scrollToItem = scrollToItem
        self.picControllerFactory = ViewControllerFactory()
        super.init()
    }
    
    public init(rootController: NavigationController, impressionID: Int, scrollToItem: Int) {
        self.rootController = rootController
        self.impressionID = impressionID
        self.scrollToItem = scrollToItem
        self.picControllerFactory = ViewControllerFactory()
        super.init()
    }
    
    public override func start() {
        rootController?.setNavigationBarHidden(true, animated: true)
        showPicController()
    }
        
    private func showPicController() {
        let controller = picControllerFactory.makePicController()
        if let offerID = offerID {
            controller.offerID = offerID
        } else if let impressionID = impressionID {
            controller.impressionID = impressionID
        }
        
        controller.scrollToItem = scrollToItem
          
        controller.didPressedCloseButton = { [weak self] in
            self?.rootController?.popViewController(animated: true)
        }
        
        rootController?.pushViewController(controller, animated: true)
    }
    
    private func showError(error: Error) {
        print("Error \(error.localizedDescription)")
    }
}
