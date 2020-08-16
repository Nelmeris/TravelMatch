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
                                       name: hideKeyboardNotificationName,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: selector,
                                       name: showKeyboardNotificationName,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: selector,
                                       name: changeKeyboardFrameNotificationName,
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
    func shiftContent(with keyboardState: KeyboardState,
                      element: UIView,
                      bottomConstraint: NSLayoutConstraint,
                      padding: CGFloat) {
        var updatedConstant: CGFloat!
        var keyboardFrame: CGRect?
        switch keyboardState {
        case .willHide: // Сброс при скрытии клавиатуры
            updatedConstant = padding
        case .willChangeFrame(let frame): keyboardFrame = frame
        case .willShow(let frame): keyboardFrame = frame
        }
        if let keyboardFrame = keyboardFrame {
            let originalBottomYPosition = element.frame.maxY + bottomConstraint.constant
            updatedConstant = originalBottomYPosition - keyboardFrame.minY + padding
        }
        guard updatedConstant != bottomConstraint.constant else { return }
        bottomConstraint.constant = updatedConstant
        view.layoutIfNeeded()
    }
    
}
