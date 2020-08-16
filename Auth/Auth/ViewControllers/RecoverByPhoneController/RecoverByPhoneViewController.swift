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
    case error(String)
}

class RecoverByPhoneViewController: BaseScrollViewController {
    
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
    
    @IBOutlet private weak var nextButton: Button?
    @IBOutlet private weak var phoneField: PhoneNumberField?
    
    @IBOutlet weak var buttonsWrapView: UIView!
    @IBOutlet private weak var buttonsBottomConstraint: NSLayoutConstraint!
    
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
        case .initial(let phone):
            phoneField?.text = phone
            phoneField?.isInvalid = false
            nextButton?.isEnabled = isInputValid()
            hideActivityIndicator()
        case .loading:
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
    
    @IBAction func emailModeClicked(_ sender: Any) {
        onEmailModeClicked?()
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        guard isInputValid(),
            let phoneValue = phoneField?.text else { return }
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
