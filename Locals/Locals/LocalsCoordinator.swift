//
//  LocalsCoordinator.swift
//  Locals
//
//  Created by Maxim Timokhin on 01.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import Core

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
    
}
