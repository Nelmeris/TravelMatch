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
        navigationController?.navigationBar.tintColor = UIColor.ThemeColors.blackColor
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
    
    // MARK: - Activity indicator
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: .zero)
        indicator.isHidden = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 64.0),
            indicator.heightAnchor.constraint(equalToConstant: 64.0),
        ])
        return indicator
    }()
    
    public func showActivityIndicator() {
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 0.5
        }
    }
    
    public func hideActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 1
        }
    }
    
    // MARK: - Display errors
    public func showCommonError(_ error: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: error,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(
            title: "Ok",
            style: UIAlertAction.Style.default,
            handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
