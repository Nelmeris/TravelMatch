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

class PhoneViewController: BaseScrollViewController {
    
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
    
    @IBOutlet private weak var nextButton: Button?
    @IBOutlet private weak var guestButton: Button?
    @IBOutlet private weak var facebookButton: Button?
    @IBOutlet private weak var phoneField: PhoneNumberField?
    
    @IBOutlet weak var buttonsWrapView: UIView!
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
    
    func isInputValid() -> Bool {
        return phoneField?.isValidNumber ?? false
    }
    
    // MARK: - Actions
    
    @IBAction func scrollViewTapAction(_ sender: Any) {
        scrollView?.endEditing(true)
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
    
    // MARK: - Keyboard
    
    override func keyboardWillChangeState(_ state: KeyboardState) {
        super.keyboardWillChangeState(state)
        updateButtons(with: state)
    }
    
    private func updateButtons(with keyboardState: KeyboardState) {
        switch keyboardState {
        case .hide:
            facebookButton?.alpha = 1
            facebookButton?.isHidden = false
            guestButton?.alpha = 1
            guestButton?.isHidden = false
        case .show:
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

extension PhoneViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return isInputValid()
    }
    
}
