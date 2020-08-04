//
//  BaseViewController+Keyboard.swift
//  UI
//
//  Created by Artem Kufaev on 04.08.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

fileprivate let hideKeyboardNotificationName = UIResponder.keyboardWillHideNotification
fileprivate let showKeyboardNotificationName = UIResponder.keyboardWillShowNotification
fileprivate let changeKeyboardFrameNotificationName = UIResponder.keyboardWillChangeFrameNotification

public extension BaseViewController {
    
    /// Включение скрытия клавиатуры по нажатию на фон
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    func registerForKeyboardNotifications(notificationCenter: NotificationCenter,
                                          with selector: Selector) {
        notificationCenter.addObserver(self,
                                       selector: selector,
                                       name: changeKeyboardFrameNotificationName,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: selector,
                                       name: hideKeyboardNotificationName,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: selector,
                                       name: showKeyboardNotificationName,
                                       object: nil)
    }
    
    func removeKeyboardNotifications(notificationCenter: NotificationCenter) {
        notificationCenter.removeObserver(self,
                                          name: changeKeyboardFrameNotificationName,
                                          object: nil)
        notificationCenter.removeObserver(self,
                                          name: hideKeyboardNotificationName,
                                          object: nil)
        notificationCenter.removeObserver(self,
                                          name: showKeyboardNotificationName,
                                          object: nil)
    }
    
    /// Поднимает передаваемый элемент при открытии клавиатуры через его нижний констрейнт
    /// - Parameters:
    ///   - keyboardNotification: Уведомление клавиатуры
    ///   - element: Поднимаемый элемент
    ///   - bottomConstraint: Нижний констрейнт
    ///   - padding: Базовый отступ
    func shiftContent(with keyboardNotification: Notification,
                      element: UIView,
                      bottomConstraint: NSLayoutConstraint,
                      padding: CGFloat) {
        switch keyboardNotification.name {
        case hideKeyboardNotificationName: // Сброс при скрытии клавиатуры
            bottomConstraint.constant = padding
        default:
            guard let keyboardFrame = KeyboardHelper.parseFrame(from: keyboardNotification) else { return }
            // Восстановление "чистой" Y позиции элемента
            let originalBottomYPosition = element.frame.maxY + bottomConstraint.constant
            bottomConstraint.constant = originalBottomYPosition - keyboardFrame.minY + padding
        }
        view.layoutIfNeeded()
    }
    
}
