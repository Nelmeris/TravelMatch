//
//  SignUpViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 17.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI
import Core

enum SignUpViewControllerState {
    case initial
    case loading
    case error(String)
}

class SignUpViewController: BaseScrollViewController {
    
    // MARK: - Input

    var state: SignUpViewControllerState? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Output
    
    var onFacebookButtonClicked: (() -> Void)?
    var onContinueButtonClicked: ((String, String) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var nameField: TextField?
    @IBOutlet private weak var passwordField: TextField?
    @IBOutlet private weak var facebookButton: Button?
    @IBOutlet private weak var nextButton: Button?
    @IBOutlet private weak var titleLabel: Label?
    
    @IBOutlet weak var buttonsWrapView: UIView!
    @IBOutlet private weak var buttonsBottomConstraint: NSLayoutConstraint!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        shiftedContent = (element: buttonsWrapView,
                          bottomConstraint: buttonsBottomConstraint,
                          padding: 0)
        navigationController?.navigationBar.topItem?.title = ""
        nameField?.autocorrectionType = .no
        nextButton?.isEnabled = isInputValid()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
        updateView()
    }
    
    // MARK: - Update view

    private func updateView() {
        guard let state = state else { return }
        switch state {
        case .initial:
            hideActivityIndicator()
            facebookButton?.isEnabled = true
            nextButton?.isEnabled = isInputValid()
        case .loading:
            facebookButton?.isEnabled = false
            nextButton?.isEnabled = false
            showActivityIndicator()
        case .error(let error):
            facebookButton?.isEnabled = false
            nextButton?.isEnabled = false
            hideActivityIndicator()
            showCommonError(error)
        }
    }
    
    func isInputValid() -> Bool {
        guard let nameValue = nameField?.text,
            Validator.isValid(value: nameValue, type: .name),
            let passwordValue = passwordField?.text,
            Validator.isValid(value: passwordValue, type: .password)
            else {return false}
        
        return true
    }
    
    // MARK: - Actions
    
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
        case .willShow:
            guard facebookButton?.alpha != 0 else { return }
            facebookButton?.alpha = 0
            facebookButton?.isHidden = true
        default: break
        }
    }
    
}
