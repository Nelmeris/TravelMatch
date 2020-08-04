//
//  BaseScrollViewController.swift
//  UI
//
//  Created by Artem Kufaev on 04.08.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

open class BaseScrollViewController: BaseViewController {
    
    // MARK: - Properties
    
    /// Дополнительное поле для хранения активного текстового поля
    public var activeTextField: UITextField?
    
    // MARK: - Outlets
    
    @IBOutlet public weak var scrollView: ScrollView!
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications(notificationCenter: notificationCenter,
                                         with: #selector(adjustForKeyboard))
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications(notificationCenter: notificationCenter)
    }
    
    deinit {
        removeNotifications()
        removeKeyboardNotifications(notificationCenter: notificationCenter)
    }
    
    // MARK: - Overridable
    
    @objc
    open func adjustForKeyboard(_ notification: Notification) { }
    
    // MARK: - Public
    
    /// Фокусировка контентного скролла по указанному текстовому полю с учетом клавиатуры
    /// - Parameters:
    ///   - textField: Текстовое поле для фокусирования
    ///   - keyboardNotification: Клавиатурное уведомление
    public func focusingOnTextField(_ textField: UITextField,
                                    with keyboardNotification: Notification) {
        var yPosition = textField.frame.midY
        // Не центрировать, если клавиатура скрыта
        if keyboardNotification.name == UIResponder.keyboardWillHideNotification {
            yPosition = 0
        }
        scrollView.focusing(on: yPosition, animated: true) // Центрирование
    }
    
    public func focusingOnActiveTextField(with keyboardNotification: Notification) {
        guard let textField = activeTextField else { return }
        focusingOnTextField(textField, with: keyboardNotification)
    }
    
}
