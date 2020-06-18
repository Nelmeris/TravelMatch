//
//  EmailViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 14.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {
    
    // MARK: - Output
    
    var onPhoneModeClicked: (() -> Void)?
    var onGuestButtonClicked: (() -> Void)?
    var onFacebookButtonClicked: (() -> Void)?
    var onContinueButtonClicked: ((String) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextButton: Button!
    @IBOutlet weak var guestButton: Button!
    @IBOutlet weak var facebookButton: Button!
    @IBOutlet weak var emailField: TextField!
    
    @IBOutlet var buttonsHeightConstraint: NSLayoutConstraint!
    @IBOutlet var formHeightConstraint: NSLayoutConstraint!
    
    private let emailPredicate = NSPredicate(
        format: "SELF MATCHES %@",
        "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector:
            #selector(self.keyboardWillShown), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:
            #selector(self.keyboardWillBeHidden(notification:)), name:
            UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:
            UIResponder.keyboardWillHideNotification, object: nil)
    }
    
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
                    ) as? NSValue)?.cgRectValue.size
            else { return }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom:
            kbSize.height, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        NSLayoutConstraint.deactivate([
            buttonsHeightConstraint
        ])
        
        let buttonSpaceHeight: CGFloat = 128
        formHeightConstraint.constant =
            (view.frame.height - kbSize.height - buttonSpaceHeight)
            - view.frame.height * formHeightConstraint.multiplier
        
        guestButton.alpha = 0
        guestButton.isHidden = true
        
        facebookButton.alpha = 0
        facebookButton.isHidden = true
        
        view.setNeedsLayout()
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        guestButton.alpha = 1
        guestButton.isHidden = false
        facebookButton.alpha = 1
        facebookButton.isHidden = false
        
        NSLayoutConstraint.activate([
            buttonsHeightConstraint
        ])
        
        formHeightConstraint.constant = 0
        
        view.setNeedsLayout()
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
