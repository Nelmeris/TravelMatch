//
//  EmailViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 14.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI
import Core

enum EmailViewControllerState {
    case initial(String?)
    case loading
    case error(String)
}

class EmailViewController: BaseScrollViewController {
    
    // MARK: - Input
    
    var state: EmailViewControllerState? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Output
    
    var onPhoneModeClicked: (() -> Void)?
    var onGuestButtonClicked: (() -> Void)?
    var onFacebookButtonClicked: (() -> Void)?
    var onContinueButtonClicked: ((String) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var emailField: TextField?
    @IBOutlet private weak var guestButton: Button?
    @IBOutlet private weak var facebookButton: Button?
    @IBOutlet private weak var nextButton: Button?
    
    @IBOutlet private weak var buttonsWrapView: UIView!
    @IBOutlet private weak var buttonsBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shiftedContent = (element: buttonsWrapView,
                          bottomConstraint: buttonsBottomConstraint,
                          padding: 0)
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
            emailField?.isEnabled = true
            emailField?.isInvalid = false
            guestButton?.isEnabled = true
            facebookButton?.isEnabled = true
            nextButton?.isEnabled = isInputValid()
            hideActivityIndicator()
        case .loading:
            emailField?.isEnabled = false
            emailField?.isInvalid = false
            guestButton?.isEnabled = false
            facebookButton?.isEnabled = false
            nextButton?.isEnabled = false
            showActivityIndicator()
        case .error(let error):
            hideActivityIndicator()
            emailField?.isInvalid = true
            print(error)
        }
        
    }
    
    // MARK: - Validation
    
    func isInputValid() -> Bool {
        guard let emailValue = emailField?.text,
            Validator.isValid(value: emailValue, type: .email)
            else {return false}
        
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func scrollViewTapAction(_ sender: Any) {
        scrollView?.endEditing(true)
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
    
    override func keyboardWillChangeState(_ state: KeyboardState) {
        super.keyboardWillChangeState(state)
        updateButtons(with: state)
    }
    
    private func updateButtons(with keyboardState: KeyboardState) {
        switch keyboardState {
        case .willHide:
            facebookButton?.alpha = 1
            facebookButton?.isHidden = false
            guestButton?.alpha = 1
            guestButton?.isHidden = false
        case .willShow:
            guard facebookButton?.alpha != 0 else { return }
            facebookButton?.alpha = 0
            facebookButton?.isHidden = true
            guestButton?.alpha = 0
            guestButton?.isHidden = true
        default: break
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension EmailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return isInputValid()
    }
    
}
