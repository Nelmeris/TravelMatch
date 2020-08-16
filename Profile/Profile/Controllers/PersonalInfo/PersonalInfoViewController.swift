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

protocol PersonalInfoViewInput: class {
    func displayPersonalInfo(_ info: PersonalInfo)
}

class PersonalInfoViewController: BaseScrollViewController {

    typealias SaveData = (name: String, surname: String, gender: String, email: String, phoneNumber: String, password: String)
    
    let padding: CGFloat = 20
    
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
    @IBOutlet weak var saveChangesButton: Button!
    
    // MARK: - Output
    
    public var onSaving: ((_ data: SaveData) -> ())?
    
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
        presenter?.presentPersonalInfo()
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
    
    @IBAction func save(_ sender: Any) {
        guard let name = nameField.text,
            let surname = surnameField.text,
            let gender = genderSelector.value,
            let email = emailField.text,
            let phoneNumber = phoneNumberField.text,
            let password = passwordField.text else { return }
        onSaving?((name, surname, gender, email, phoneNumber, password))
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

extension PersonalInfoViewController: PersonalInfoViewInput {
    
    func displayPersonalInfo(_ info: PersonalInfo) {
        nameField.text = info.name
        surnameField.text = info.surname
        genderSelector.value = info.gender
        emailField.text = info.email
        let phoneNumber = try? phoneNumberField.phoneNumberKit.parse(info.phoneNumber)
        phoneNumberField.text = phoneNumber?.numberString
        phoneNumberField.updateFlag()
    }
    
}
