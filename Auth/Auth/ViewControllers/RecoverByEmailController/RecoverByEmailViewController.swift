//
//  RecoverByEmailViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 22.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI
import Core

enum RecoverByEmailViewControllerState {
    case initial(String?)
    case loading
    case error(String)
}

class RecoverByEmailViewController: BaseViewController {
    
    // MARK: - Input
    
    var state: RecoverByEmailViewControllerState? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Output
    
    var onPhoneModeClicked: (() -> Void)?
    var onContinueButtonClicked: ((String) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var scrollView: UIScrollView?
    @IBOutlet private weak var emailField: TextField?
    @IBOutlet private weak var nextButton: Button?
    
    @IBOutlet private weak var buttonsBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    // MARK: - Update view
    
    private func updateView() {
        guard let state = state else { return }
        
        switch state {
        case .initial(let email):
            emailField?.text = email
            emailField?.isInvalid = false
            nextButton?.isEnabled = isInputValid()
            hideActivityIndicator()
        case .loading:
            nextButton?.isEnabled = false
            showActivityIndicator()
        case .error(let error):
            hideActivityIndicator()
            emailField?.isInvalid = true
            print(error)
        }
        
    }
    
    // MARK: - Notifications
    
    override func addNotifications() {
        super.addNotifications()
        notificationCenter.addObserver(self, selector:
            #selector(self.keyboardWillShown), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        
        notificationCenter.addObserver(self, selector:
            #selector(self.keyboardWillHide(notification:)), name:
            UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func removeNotifications() {
        super.removeNotifications()
        notificationCenter.removeObserver(self, name:
            UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name:
            UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Validation
    
    func isInputValid() -> Bool {
        guard let emailValue = emailField?.text,
            Validator.isValid(value: emailValue, type: .email)
            else { return false }
        
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func scrollViewTapAction(_ sender: Any) {
        scrollView?.endEditing(true)
    }
    
    @IBAction func phoneModeClicked(_ sender: Any) {
        onPhoneModeClicked?()
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        guard isInputValid(),
            let emailValue = emailField?.text else {return}
        onContinueButtonClicked?(emailValue)
        scrollView?.endEditing(true)
    }
    
    @IBAction func emailValueChanged(_ sender: Any) {
        nextButton?.isEnabled = isInputValid()
    }
    
    @IBAction func emailFieldDidEndOnExit(_ sender: Any) {
        continueButtonClicked(sender)
    }
    
    // MARK: - Keyboard
    
    @objc func keyboardWillShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        
        guard
            let kbSize = (
                info.value(
                    forKey: UIResponder.keyboardFrameEndUserInfoKey
                    ) as? NSValue)?.cgRectValue.size,
            kbSize.height > buttonsBottomConstraint?.constant ?? 0
            else { return }
        
        buttonsBottomConstraint?.constant = kbSize.height
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        buttonsBottomConstraint?.constant = 0
    }
    
}

// MARK: - UITextFieldDelegate

extension RecoverByEmailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return isInputValid()
    }
    
}
