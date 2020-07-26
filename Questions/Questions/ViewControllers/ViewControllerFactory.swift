//
//  ViewControllerFactory.swift
//  Questions
//
//  Created by Maxim Timokhin on 25.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class ViewControllerFactory {
    
    func makeQuestionsController() -> QuestionsViewController {
        return UIStoryboard(name: "Questions", bundle: Bundle(for: QuestionsViewController.self))
            .instantiateViewController(QuestionsViewController.self)
    }
    
}
