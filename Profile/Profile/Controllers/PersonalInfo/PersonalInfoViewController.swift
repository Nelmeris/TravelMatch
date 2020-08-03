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
    
    // MARK: - Outlets

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameField: TextField!
    @IBOutlet weak var surnameField: TextField!
    @IBOutlet weak var genderSelector: DropdownControl!
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var phoneNumberField: PhoneNumberField!
    @IBOutlet weak var passwordField: TextField!
    
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
        scrollView.shiftContent(of: notification) // Сдвиг
        guard let position = activeTextField?.frame.midY else { return }
        scrollView.centering(on: position, animated: true) // Центрирование
    }
    
}

extension PersonalInfoViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
}

extension UIViewController {
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    func registerForKeyboardNotifications(notificationCenter: NotificationCenter,
                                          with selector: Selector) {
        notificationCenter.addObserver(self,
                                       selector: selector,
                                       name: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: selector,
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }
    
    func removeKeyboardNotifications(notificationCenter: NotificationCenter) {
        notificationCenter.removeObserver(self,
                                          name: UIResponder.keyboardWillChangeFrameNotification,
                                          object: nil)
        notificationCenter.removeObserver(self,
                                          name: UIResponder.keyboardWillHideNotification,
                                          object: nil)
    }
    
}

extension UIScrollView {
    
    func shiftContent(of keyboardNotification: Notification) {
        guard let keyboardValue = keyboardNotification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardValue.cgRectValue
        
        switch keyboardNotification.name {
        case UIResponder.keyboardWillHideNotification:
            // Сброс при скрытии клавиатуры
            contentInset = .zero
            setContentOffset(.zero, animated: true)
        default:
            // Отступ от нижнего края
            let bottomInset = frame.maxY - keyboardFrame.minY
            guard bottomInset > 0 else { return }
            contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0) // Отступ от нижнего края
        }
    }
    
    func centering(on yPosition: CGFloat, animated: Bool) {
        let height = frame.height - contentInset.bottom - contentInset.top
        
        var centeringPoint: CGPoint?
        if yPosition - height / 2 < 0 { // Если выходит за границу сверху
            centeringPoint = .zero
        } else if yPosition + height / 2 > contentSize.height { // Если выходит за границу снизу
            centeringPoint = CGPoint(x: 0, y: contentSize.height - height)
        } else { // Центрирование на элементе
            centeringPoint = CGPoint(x: 0, y: yPosition - height / 2)
        }
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.contentOffset = centeringPoint!
            }
        } else {
            contentOffset = centeringPoint!
        }
    }
    
}
