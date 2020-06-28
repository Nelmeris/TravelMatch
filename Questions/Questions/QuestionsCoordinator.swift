//
//  QuestionsCoordinator.swift
//  Questions
//
//  Created by Maxim Timokhin on 25.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import Core
import UI

public final class QuestionsCoordinator: BaseCoordinator {

    private let viewControllerFactory: ViewControllerFactory
    
    private weak var rootController: UINavigationController?
    
    public init(
        rootController: UINavigationController
    ) {
        self.rootController = rootController
        viewControllerFactory = ViewControllerFactory()
    }
    
    public override func start() {
        let controller = viewControllerFactory.makeQuestionsController()        
        rootController?.viewControllers = [controller]
    }
    
}
