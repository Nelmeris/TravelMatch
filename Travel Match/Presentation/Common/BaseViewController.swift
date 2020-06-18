//
//  BaseViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 18.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var notificationCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotifications()
    }

    deinit {
        removeNotifications()
    }
    
    // MARK: - Notifications
    
    func addNotifications() {
        
    }
    
    func removeNotifications() {
        
    }
    
}
