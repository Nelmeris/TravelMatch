//
//  PhoneViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 16.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

enum PhoneViewControllerState {
    case initial(String?)
    case loading
    case error(String)
}

class PhoneViewController: BaseViewController {
    
    // MARK: - Input
    
    var state: PhoneViewControllerState? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Output
    
    var onEmailModeClicked: (() -> Void)?
    var onGuestButtonClicked: (() -> Void)?
    var onFacebookButtonClicked: (() -> Void)?
    var onContinueButtonClicked: ((String) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var scrollView: UIScrollView?
    @IBOutlet private weak var nextButton: Button?
    @IBOutlet private weak var guestButton: Button?
    @IBOutlet private weak var facebookButton: Button?
    @IBOutlet private weak var phoneField: PhoneNumberField?
    
    @IBOutlet private weak var buttonsBottomConstraint: NSLayoutConstraint?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    // MARK: - Update view
    
    private func updateView() {
        guard let state = state else {return}
        
        switch state {
        case .initial(let phone):
            phoneField?.text = phone
            phoneField?.isEnabled = true
            phoneField?.isInvalid = false
            guestButton?.isEnabled = true
            facebookButton?.isEnabled = true
            nextButton?.isEnabled = isInputValid()
            hideActivityIndicator()
        case .loading:
            phoneField?.isEnabled = false
            phoneField?.isInvalid = false
            guestButton?.isEnabled = false
            facebookButton?.isEnabled = false
            nextButton?.isEnabled = false
            showActivityIndicator()
        case .error(let error):
            hideActivityIndicator()
            phoneField?.isInvalid = true
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
    
    func isInputValid() -> Bool {
        guard phoneField?.isValidNumber ?? false
            else {return false}
        
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func scrollViewTapAction(_ sender: Any) {
        scrollView?.endEditing(true)
    }
    
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
        
        guestButton?.alpha = 0
        guestButton?.isHidden = true
        
        facebookButton?.alpha = 0
        facebookButton?.isHidden = true
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        buttonsBottomConstraint?.constant = 0
        guestButton?.alpha = 1
        guestButton?.isHidden = false
        facebookButton?.alpha = 1
        facebookButton?.isHidden = false
    }
    
    @IBAction func emailModeClicked(_ sender: Any) {
        onEmailModeClicked?()
    }
    
    @IBAction func guestButtonClicked(_ sender: Any) {
        onGuestButtonClicked?()
    }
    
    @IBAction func facebookButtonClicked(_ sender: Any) {
        onFacebookButtonClicked?()
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        guard isInputValid(),
            let phoneValue = phoneField?.text else {return}
        onContinueButtonClicked?(phoneValue)
        scrollView?.endEditing(true)
    }
    
    @IBAction func emailValueChanged(_ sender: Any) {
        nextButton?.isEnabled = isInputValid()
    }
    
    @IBAction func emailFieldDidEndOnExit(_ sender: Any) {
        continueButtonClicked(sender)
    }
    
}

// MARK: - UITextFieldDelegate

extension PhoneViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return isInputValid()
    }
    
}
