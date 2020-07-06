//
//  ViewControllerFactory.swift
//  Locals
//
//  Created by Maxim Timokhin on 01.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import UIKit
import UI

class ViewControllerFactory {
    
    func makeLocalsController() -> LocalsViewController {
        return UIStoryboard(name: "Locals", bundle: Bundle(for: LocalsViewController.self))
            .instantiateViewController(LocalsViewController.self)
    }
    
}

