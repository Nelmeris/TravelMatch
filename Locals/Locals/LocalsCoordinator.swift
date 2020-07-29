//
//  LocalsCoordinator.swift
//  Locals
//
//  Created by Maxim Timokhin on 01.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import Core
import UIKit

public final class LocalsCoordinator: BaseCoordinator {
    
    private let viewControllerFactory: ViewControllerFactory
    private weak var rootController: NavigationController?
    
    private let localsService: LocalsService
    
    public init(
        rootController: NavigationController,
        localsService: LocalsService
    ) {
        self.rootController = rootController
        self.localsService = localsService
        self.viewControllerFactory = ViewControllerFactory()
    }
    
    public override func start() {
        let controller = viewControllerFactory.makeLocalsController()
        
        controller.onFilterButtonClicked = { [weak self] in
            self?.showFilter()
        }
        
        controller.onLocalSelected = { [weak self] local in
            self?.showLocal(local)
        }
        
        controller.state = .loading
        
        localsService.search(request: nil) { [weak controller] result in
            switch result {
            case .success(let locals):
                controller?.state = .initial(locals)
            case .failure(let error):
                controller?.state = .error(error.localizedDescription)
            }
        }
        
        rootController?.viewControllers = [controller]        
    }
    
    private func showLocal(_ local: Local) {
        let controller = viewControllerFactory.makeLocalController()
        controller.local = local
        
        controller.onInterestClicked = { interest in
            print("Interest clicked \(interest.title)")
        }
        
        controller.onBookingClicked = {
            print("Go to booking")
        }
        
        controller.onMessageClicked = {
            print("Go to chat")
        }
        
        rootController?.pushViewController(controller, animated: true)
    }
    
    private func showFilter() {
        let controller = viewControllerFactory.makeFilterViewController()
        controller.modalPresentationStyle = .fullScreen
        
        controller.onClose = { [weak controller] in
            controller?.dismiss(animated: true, completion: nil)
        }
     
        controller.onSubmit = { [weak controller] in
            controller?.dismiss(animated: true, completion: nil)
        }
        
        controller.onChooseLanguage = { [weak self, weak controller] in
            self?.showLanguagePicker(from: controller)
        }
        
        rootController?.present(controller, animated: true, completion: nil)        
    }
    
    private func showLanguagePicker(from viewController: UIViewController?) {
        let controller = viewControllerFactory.makeFilterValuesController()
        controller.title = "Язык"
        controller.values = [
            FilterValue(title: "Русский"),
            FilterValue(title: "Английский"),
            FilterValue(title: "Испанский"),
            FilterValue(title: "Китайский"),
        ]
        
        controller.onChangeSelection = { indicies in
            print("Selection \(indicies)")
        }
        
        viewController?.present(controller, animated: true, completion: nil)
    }
    
}
