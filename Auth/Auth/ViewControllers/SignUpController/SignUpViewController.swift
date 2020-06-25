//
//  SignUpViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 17.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class SignUpViewController: BaseViewController {

    // MARK: - Output
    
    var onFacebookButtonClicked: (() -> Void)?
    var onContinueButtonClicked: ((String, String) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var scrollView: UIScrollView?
    @IBOutlet private weak var nameField: TextField?
    @IBOutlet private weak var passwordField: TextField?
    @IBOutlet private weak var facebookButton: Button?
    @IBOutlet private weak var nextButton: Button?

    @IBOutlet private weak var buttonsBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Validation
    
    private let namePredicate = NSPredicate(
        format: "SELF MATCHES %@",
        ".{2,}"
    )
    
    private let passwordPredicate = NSPredicate(
        format: "SELF MATCHES %@",
        ".{6,}"
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = ""
        nameField?.autocorrectionType = .no
        nextButton?.isEnabled = isInputValid()
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
        guard let nameValue = nameField?.text,
            namePredicate.evaluate(with: nameValue),
            let passwordValue = passwordField?.text,
            passwordPredicate.evaluate(with: passwordValue)
            else {return false}
        
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func scrollViewTapAction(_ sender: Any) {
        scrollView?.endEditing(true)
    }
        
    @IBAction func facebookButtonClicked(_ sender: Any) {
        onFacebookButtonClicked?()
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        guard let nameValue = nameField?.text,
            let passwordValue = passwordField?.text
            else {return}
        
        onContinueButtonClicked?(nameValue, passwordValue)
    }
    
    @IBAction func nameFieldChanged(_ sender: Any) {
        nextButton?.isEnabled = isInputValid()
    }

    @IBAction func nameFieldDidEndOnExit(_ sender: Any) {
        passwordField?.becomeFirstResponder()
    }
    
    @IBAction func passwordFieldChanged(_ sender: Any) {
        nextButton?.isEnabled = isInputValid()
    }
    
    @IBAction func passwordFieldDidEndOnExit(_ sender: Any) {
        guard isInputValid() else {return}
        continueButtonClicked(sender)
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
        facebookButton?.alpha = 0
        facebookButton?.isHidden = true
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        buttonsBottomConstraint?.constant = 0
        facebookButton?.alpha = 1
        facebookButton?.isHidden = false
    }

}
