//
//  RecoverByPhoneViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 22.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

enum RecoverByPhoneViewControllerState {
    case initial(String?)
    case loading
}

class RecoverByPhoneViewController: BaseViewController {
    
    // MARK: - Input
    
    var state: RecoverByPhoneViewControllerState? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Output
    
    var onEmailModeClicked: (() -> Void)?
    var onContinueButtonClicked: ((String) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var scrollView: UIScrollView?
    @IBOutlet private weak var nextButton: Button?
    @IBOutlet private weak var phoneField: PhoneNumberField?
    
    @IBOutlet private weak var buttonsBottomConstraint: NSLayoutConstraint?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
        updateView()
    }
    
    // MARK: - Update view
    
    private func updateView() {
        guard let state = state else { return }
        
        switch state {
        case .initial(let phone):
            phoneField?.text = phone
            nextButton?.isEnabled = isInputValid()
        case .loading:
            nextButton?.isEnabled = false
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
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        buttonsBottomConstraint?.constant = 0
    }
    
    @IBAction func emailModeClicked(_ sender: Any) {
        onEmailModeClicked?()
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

extension RecoverByPhoneViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return isInputValid()
    }
    
}
