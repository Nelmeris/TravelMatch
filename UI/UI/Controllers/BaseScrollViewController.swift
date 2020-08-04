//
//  BaseScrollViewController.swift
//  UI
//
//  Created by Artem Kufaev on 04.08.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

open class BaseScrollViewController: BaseViewController {
    
    public var activeTextField: UITextField?
    @IBOutlet public weak var scrollView: ScrollView!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        registerForKeyboardNotifications(notificationCenter: notificationCenter,
                                         with: #selector(adjustForKeyboard))
    }
    
    deinit {
        removeKeyboardNotifications(notificationCenter: notificationCenter)
    }
    
    // MARK: - Private
    
    @objc
    open func adjustForKeyboard(_ notification: Notification) { }
    
    public func centeringOnTextField(_ textField: UITextField,
                                      with keyboardNotification: Notification) {
        var yPosition = textField.frame.midY
        // Не центрировать, если клавиатура скрыта
        if keyboardNotification.name == UIResponder.keyboardWillHideNotification {
            yPosition = 0
        }
        scrollView.centering(on: yPosition, animated: true) // Центрирование
    }
    
}
