//
//  PersonalInfoViewController.swift
//  Profile
//
//  Created by Artem Kufaev on 29.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import UI

class PersonalInfoViewController: BaseScrollViewController {
    
    let padding: CGFloat = 20
    
    // MARK: - Outlets

    @IBOutlet weak var nameField: TextField!
    @IBOutlet weak var surnameField: TextField!
    @IBOutlet weak var genderSelector: DropdownControl!
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var phoneNumberField: PhoneNumberField!
    @IBOutlet weak var passwordField: TextField!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var saveChangesButton: Button!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        surnameField.delegate = self
        emailField.delegate = self
        phoneNumberField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func adjustForKeyboard(_ notification: Notification) {
        guard let keyboardFrame = KeyboardHelper.parseFrame(from: notification),
            keyboardFrame.height != 0 else { return }
        shiftContent(with: notification,
                     element: saveChangesButton,
                     bottomConstraint: buttonBottomConstraint,
                     padding: padding)
        guard let textField = activeTextField else { return }
        scrollView.focusing(on: textField.frame.midY, animated: true)
    }
    
}

extension PersonalInfoViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
}
