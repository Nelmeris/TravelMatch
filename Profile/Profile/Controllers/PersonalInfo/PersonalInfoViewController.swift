//
//  PersonalInfoViewController.swift
//  Profile
//
//  Created by Artem Kufaev on 29.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import UI
import PhoneNumberKit
import Core

protocol PersonalInfoViewInput: class {
    func displayPersonalInfo(_ info: PersonalInfo)
}

class PersonalInfoViewController: BaseScrollViewController {

    typealias SaveData = (name: String, surname: String, gender: String, email: String, phoneNumber: String, password: String)
    
    let padding: CGFloat = 20
    var fields: [UITextField] = []
    
    // MARK: - Input
    
    var presenter: PersonalInfoOutput?
    
    // MARK: - Outlets

    @IBOutlet weak var nameField: TextField!
    @IBOutlet weak var surnameField: TextField!
    @IBOutlet weak var genderSelector: DropdownControl!
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var phoneNumberField: PhoneNumberField!
    @IBOutlet weak var passwordField: TextField!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var saveChangesButton: PrimaryButton!
    
    // MARK: - Output
    
    public var onSaving: ((_ data: SaveData) -> ())?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
        presenter?.presentPersonalInfo()
    }
    
    override func adjustForKeyboard(_ notification: Notification) {
        guard let keyboardFrame = KeyboardHelper.parseFrame(from: notification),
            keyboardFrame.height != 0 else { return }
        shiftContent(with: notification,
                     element: saveChangesButton,
                     bottomConstraint: buttonBottomConstraint,
                     padding: padding)
        guard let textField = activeTextField, notification.name != UIResponder.keyboardWillHideNotification else { return }
        scrollView.focusing(on: textField.frame.midY, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func save(_ sender: Any) {
        guard let name = nameField.text,
            let surname = surnameField.text,
            let gender = genderSelector.value,
            let email = emailField.text,
            let phoneNumber = phoneNumberField.text,
            let password = passwordField.text else { return }
        onSaving?((name, surname, gender, email, phoneNumber, password))
    }
    
    // MARK: - Private
    
    private func configureFields() {
        fields = [nameField, surnameField, emailField, phoneNumberField, passwordField]
        fields.forEach {
            $0.delegate = self
            $0.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        }
    }
    
    @objc
    private func textFieldDidChanged(_ textField: UITextField) {
        saveChangesButton.isEnabled = isFormValid()
    }
    
    // MARK: Validators
    
    private func isFormValid() -> Bool {
        return ![
            validateName(),
            validateSurname(),
            validatePhoneNumberAndEmail(),
            validatePassword()
        ].contains(false)
    }
    
    private func validateName() -> Bool {
        guard let name = nameField.text, !name.isEmpty else {
//            showCommonError("Необходимо указать ваше имя")
            nameField.isInvalid = true
            return false
        }
        guard Validator.isValid(value: name, type: .name) else {
//            showCommonError("Имя некорректно")
            nameField.isInvalid = true
            return false
        }
        nameField.isInvalid = false
        return true
    }
    
    private func validateSurname() -> Bool {
        if let surname = surnameField.text, !Validator.isValid(value: surname, type: .name) {
//            showCommonError("Фамилия некорректна")
            surnameField.isInvalid = true
            return false
        }
        surnameField.isInvalid = false
        return true
    }

    private func validatePhoneNumberAndEmail() -> Bool {
        var flag = true
        // EMAIL
        if let email = emailField.text, !email.isEmpty, !Validator.isValid(value: email, type: .email) {
//            showCommonError("Неверно указана почта")
            flag = false
            emailField.isInvalid = true
        } else {
            emailField.isInvalid = false
        }
        
        // PHONE
        if let phone = phoneNumberField.text, !phone.isEmpty, !phoneNumberField.phoneNumberKit.isValidPhoneNumber(phone) {
//            showCommonError("Неверно указан номер телефона")
            flag = false
            phoneNumberField.isInvalid = true
        } else {
            phoneNumberField.isInvalid = false
        }
        
        // PAIR
        if let phone = phoneNumberField.text, phone.isEmpty,
            let email = emailField.text, email.isEmpty {
//            showCommonError("Должны быть указаны либо почта, либо телефон")
            emailField.isInvalid = true
            phoneNumberField.isInvalid = true
            flag = false
        }
        return flag
    }
    
    private func validatePassword() -> Bool {
        if let password = passwordField.text, !password.isEmpty, !Validator.isValid(value: password, type: .password) {
            passwordField.isInvalid = true
            return false
        }
        passwordField.isInvalid = false
        return true
    }
    
}

extension PersonalInfoViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let index = fields.firstIndex(of: textField),
            index != fields.count - 1 {
            fields[index + 1].becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
        saveChangesButton.isEnabled = isFormValid()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.focusing(on: 0, animated: true)
        saveChangesButton.isEnabled = isFormValid()
    }
    
}

extension PersonalInfoViewController: PersonalInfoViewInput {
    
    func displayPersonalInfo(_ info: PersonalInfo) {
        nameField.text = info.name
        surnameField.text = info.surname
        genderSelector.value = info.gender
        emailField.text = info.email
        let phoneNumber = try? phoneNumberField.phoneNumberKit.parse(info.phoneNumber)
        phoneNumberField.text = phoneNumber?.numberString
        phoneNumberField.updateFlag()
        saveChangesButton.isEnabled = isFormValid()
    }
    
}
