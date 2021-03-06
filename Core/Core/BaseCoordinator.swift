//
//  BaseCoordinator.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import UIKit

open class BaseCoordinator {
    
    var childCoordinators: [BaseCoordinator] = []
    public var onFinishFlow: (() -> Void)?
    
    public init() {}
    
    open func start() {
        fatalError("Start method should be implemented.")
    }
    
    public func addDependency(_ coordinator: BaseCoordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator } ) else { return }
        childCoordinators.append(coordinator)
    }
    
    public func removeDependency(_ coordinator: BaseCoordinator?) {
        childCoordinators.removeAll { $0 === coordinator }
    }
    
    public func setAsRoot(_ controller: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
    
}
