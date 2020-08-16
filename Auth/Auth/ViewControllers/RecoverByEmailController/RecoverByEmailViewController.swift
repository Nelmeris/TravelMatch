//
//  RecoverByEmailViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 22.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

enum RecoverByEmailViewControllerState {
    case initial(String?)
    case loading
    case error(String)
}

class RecoverByEmailViewController: BaseScrollViewController {
    
    // MARK: - Input
    
    var state: RecoverByEmailViewControllerState? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Output
    
    var onPhoneModeClicked: (() -> Void)?
    var onContinueButtonClicked: ((String) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var emailField: TextField?
    @IBOutlet private weak var nextButton: Button?
    
    @IBOutlet weak var buttonsWrapView: UIView!
    @IBOutlet private weak var buttonsBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Validation
    
    private let emailPredicate = NSPredicate(
        format: "SELF MATCHES %@",
        "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    )
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shiftedContent = (element: buttonsWrapView,
                          bottomConstraint: buttonsBottomConstraint,
                          padding: 0)
        navigationController?.navigationBar.topItem?.title = ""
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
            emailField?.isInvalid = false
            nextButton?.isEnabled = isInputValid()
            hideActivityIndicator()
        case .loading:
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
            emailPredicate.evaluate(with: emailValue)
            else { return false }
        
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func phoneModeClicked(_ sender: Any) {
        onPhoneModeClicked?()
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
    
}

// MARK: - UITextFieldDelegate

extension RecoverByEmailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return isInputValid()
    }
    
}
