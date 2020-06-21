//
//  EmailViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 14.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

class EmailViewController: BaseViewController {
    
    // MARK: - Input
    
    var email: String?
    
    // MARK: - Output
    
    var onPhoneModeClicked: (() -> Void)?
    var onGuestButtonClicked: (() -> Void)?
    var onFacebookButtonClicked: (() -> Void)?
    var onContinueButtonClicked: ((String) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailField: TextField! {
        didSet {
            emailField.text = email
        }
    }
    @IBOutlet weak var guestButton: Button!
    @IBOutlet weak var facebookButton: Button!
    @IBOutlet weak var nextButton: Button!
    
    @IBOutlet weak var buttonsBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Validation
    
    private let emailPredicate = NSPredicate(
        format: "SELF MATCHES %@",
        "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = isInputValid()
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
        guard let emailValue = emailField.text,
            emailPredicate.evaluate(with: emailValue)
            else {return false}
        
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func scrollViewTapAction(_ sender: Any) {
        scrollView.endEditing(true)
    }
    
    @objc func keyboardWillShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        
        guard
            let kbSize = (
                info.value(
                    forKey: UIResponder.keyboardFrameEndUserInfoKey
                    ) as? NSValue)?.cgRectValue.size,
            kbSize.height > buttonsBottomConstraint.constant
            else { return }
        
        buttonsBottomConstraint.constant = kbSize.height
        
        guestButton.alpha = 0
        guestButton.isHidden = true
        
        facebookButton.alpha = 0
        facebookButton.isHidden = true
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        buttonsBottomConstraint.constant = 0
        guestButton.alpha = 1
        guestButton.isHidden = false
        facebookButton.alpha = 1
        facebookButton.isHidden = false
    }
    
    @IBAction func phoneModeClicked(_ sender: Any) {
        onPhoneModeClicked?()
    }
    
    @IBAction func guestButtonClicked(_ sender: Any) {
        onGuestButtonClicked?()
    }
    
    @IBAction func facebookButtonClicked(_ sender: Any) {
        onFacebookButtonClicked?()
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        guard isInputValid(),
            let emailValue = emailField.text else {return}
        onContinueButtonClicked?(emailValue)
        scrollView.endEditing(true)
    }
    
    @IBAction func emailValueChanged(_ sender: Any) {
        nextButton.isEnabled = isInputValid()
    }
    
    @IBAction func emailFieldDidEndOnExit(_ sender: Any) {
        continueButtonClicked(sender)
    }
    
}

// MARK: - UITextFieldDelegate

extension EmailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return isInputValid()
    }
    
}
