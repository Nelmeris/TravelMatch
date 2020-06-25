//
//  BaseViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 18.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController {

    public var notificationCenter = NotificationCenter.default
    
    open override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNotifications()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotifications()
    }

    deinit {
        removeNotifications()
    }
    
    // MARK: - Notifications
    
    open func addNotifications() {
        
    }
    
    open func removeNotifications() {
        
    }
    
}
