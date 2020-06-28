//
//  SignInViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 21.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

enum SignInViewControllerState {
    case initial(userName: String)
    case loading
    case error(error: String)
}

class SignInViewController: BaseViewController {

    // MARK: - Input
    var state: SignInViewControllerState? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Output
    
    var onRecoverButtonClicked: (() -> Void)?
    var onContinueButtonClicked: ((String, Bool) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var scrollView: UIScrollView?
    @IBOutlet private weak var titleLabel: Label?
    @IBOutlet private weak var passwordField: TextField?
    @IBOutlet private weak var rememberCheckbox: UISwitch?
    @IBOutlet private weak var nextButton: Button?

    @IBOutlet private weak var buttonsBottomConstraint: NSLayoutConstraint?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    // MARK: - Update view
    
    private func updateView() {
        guard let state = state else { return }
        
        switch state {
        case .initial(userName: let userName):
            titleLabel?.text = "Добро пожаловать, \(userName)!"
            passwordField?.isEnabled = true
            passwordField?.isInvalid = false
            nextButton?.isEnabled = isInputValid()
        case .loading:
            passwordField?.isEnabled = false
            passwordField?.isInvalid = false
            nextButton?.isEnabled = false
            showActivityIndicator()
        case .error(error: let error):
            passwordField?.isEnabled = true
            passwordField?.isInvalid = true
            nextButton?.isEnabled = isInputValid()
            print("error \(error)")
            hideActivityIndicator()
        }
    }
    
    // MARK: - Validation
    
    private let passwordPredicate = NSPredicate(
        format: "SELF MATCHES %@",
        ".{6,}"
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = ""
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
        guard let passwordValue = passwordField?.text,
            passwordPredicate.evaluate(with: passwordValue)
            else {return false}
        
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func scrollViewTapAction(_ sender: Any) {
        scrollView?.endEditing(true)
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        guard let passwordValue = passwordField?.text,
        let remember = rememberCheckbox?.isOn
            else {return}
        onContinueButtonClicked?(passwordValue, remember)
    }
    
    @IBAction func recoverButtonClicked(_ sender: Any) {
        onRecoverButtonClicked?()
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
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        buttonsBottomConstraint?.constant = 0
    }

}
