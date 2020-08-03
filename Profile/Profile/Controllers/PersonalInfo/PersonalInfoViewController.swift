//
//  PersonalInfoViewController.swift
//  Profile
//
//  Created by Artem Kufaev on 29.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import UI

class PersonalInfoViewController: UIViewController {
    
    var activeTextField: UITextField?
    let notificationCenter = NotificationCenter.default
    let padding: CGFloat = 20
    
    // MARK: - Outlets

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameField: TextField!
    @IBOutlet weak var surnameField: TextField!
    @IBOutlet weak var genderSelector: DropdownControl!
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var phoneNumberField: PhoneNumberField!
    @IBOutlet weak var passwordField: TextField!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var saveChangesButton: Button!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        registerForKeyboardNotifications(notificationCenter: notificationCenter,
                                         with: #selector(adjustForKeyboard))
        nameField.delegate = self
        surnameField.delegate = self
        emailField.delegate = self
        phoneNumberField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    deinit {
        removeKeyboardNotifications(notificationCenter: notificationCenter)
    }
    
    // MARK: - Private
    
    @objc func adjustForKeyboard(_ notification: Notification) {
        guard let keyboardFrame = KeyboardHelper.parseFrame(from: notification),
            keyboardFrame.height != 0 else { return }
        shiftContent(with: notification,
                     element: saveChangesButton,
                     bottomConstraint: buttonBottomConstraint,
                     padding: padding)
        guard let textField = activeTextField else { return }
        centeringOnTextField(textField, with: notification)
    }
    
    private func centeringOnTextField(_ textField: UITextField,
                                      with keyboardNotification: Notification) {
        var yPosition = textField.frame.midY
        // Не центрировать, если клавиатура скрыта
        if keyboardNotification.name == hideKeyboardNotificationName {
            yPosition = 0
        }
        scrollView.centering(on: yPosition, animated: true) // Центрирование
    }
    
}

// MARK: - ВРЕМЕННО ЗДЕСЬ

extension PersonalInfoViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
}

let hideKeyboardNotificationName = UIResponder.keyboardWillHideNotification
let changeKeyboardFrameNotificationName = UIResponder.keyboardWillChangeFrameNotification

extension UIViewController {
    
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
    }
    
    func removeKeyboardNotifications(notificationCenter: NotificationCenter) {
        notificationCenter.removeObserver(self,
                                          name: changeKeyboardFrameNotificationName,
                                          object: nil)
        notificationCenter.removeObserver(self,
                                          name: hideKeyboardNotificationName,
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
        case UIResponder.keyboardWillHideNotification: // Сброс при скрытии клавиатуры
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

extension UIScrollView {
    
    func shiftContent(of keyboardNotification: Notification) {
        guard let keyboardFrame = KeyboardHelper.parseFrame(from: keyboardNotification) else { return }
        
        switch keyboardNotification.name {
        case hideKeyboardNotificationName:
            // Сброс при скрытии клавиатуры
            contentInset = .zero
        default:
            // Отступ от нижнего края
            let bottomInset = frame.maxY - keyboardFrame.minY
            guard bottomInset > 0 else { return }
            contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0) // Отступ от нижнего края
        }
    }
    
    func centering(on yPosition: CGFloat, animated: Bool) {
        let height = frame.height - contentInset.bottom - contentInset.top // Видимая высота с учетом инсетов
        
        var centeringPoint: CGPoint?
        if yPosition - height / 2 < 0 { // Если выходит за границу сверху
            centeringPoint = .zero
        } else if yPosition + height / 2 > contentSize.height { // Если выходит за границу снизу
            centeringPoint = CGPoint(x: 0, y: contentSize.height - height)
        } else { // Центрирование на элементе
            centeringPoint = CGPoint(x: 0, y: yPosition - height / 2)
        }
        
        guard contentOffset != centeringPoint else { return } // Защита от повторного центрирования
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.contentOffset = centeringPoint!
            }
        } else {
            contentOffset = centeringPoint!
        }
    }
    
}

class KeyboardHelper {
    
    static func parseFrame(from notification: Notification) -> CGRect? {
        guard let userInfo = notification.userInfo,
            let keyboardValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else { return nil }
        return keyboardValue.cgRectValue
    }
    
}
