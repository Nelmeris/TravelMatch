//
//  SignInViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 21.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI
import Core

enum SignInViewControllerState {
    case initial(userName: String)
    case loading
    case error(error: String)
}

class SignInViewController: BaseScrollViewController {

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
    
    @IBOutlet private weak var titleLabel: Label?
    @IBOutlet private weak var passwordField: TextField?
    @IBOutlet private weak var rememberCheckbox: Switch?
    @IBOutlet private weak var nextButton: Button?

    @IBOutlet weak var buttonsWrapView: UIView!
    @IBOutlet private weak var buttonsBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = ""
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
    
    func isInputValid() -> Bool {
        guard let passwordValue = passwordField?.text,
            Validator.isValid(value: passwordValue, type: .password)
            else {return false}
        
        return true
    }
    
    // MARK: - Actions
    
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
    
    // MARK: - Keyboard
    
    override func adjustForKeyboard(_ notification: Notification) {
        shiftContent(with: notification,
                     element: buttonsWrapView,
                     bottomConstraint: buttonsBottomConstraint,
                     padding: 0)
    }
    
}
