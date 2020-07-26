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
    
    private let questionsService: QuestionsService
    
    public init(
        rootController: UINavigationController,
        questionsService: QuestionsService
    ) {
        self.rootController = rootController
        self.questionsService = questionsService
        viewControllerFactory = ViewControllerFactory()
    }
    
    public override func start() {
        let controller = viewControllerFactory.makeQuestionsController()
        
        controller.onContinueClicked = { [weak self, weak controller] answers in
            self?.questionsService.saveAnswers(answers) { (result) in
                switch result {
                case .success:
                    self?.onFinishFlow?()
                case .failure(let error):
                    controller?.showCommonError(error.localizedDescription)
                }
            }
        }
        
        questionsService.getQuestion { (result) in
            switch result {
            case .success(let question):
                controller.question = question
            case .failure(let error):
                controller.showCommonError(error.localizedDescription)
                print("\(#function) error \(error.localizedDescription)")
            }
        }
        
        rootController?.viewControllers = [controller]
    }
    
}
