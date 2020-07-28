//
//  PersonalInfoViewController.swift
//  Profile
//
//  Created by Artem Kufaev on 29.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import UI

class PersonalInfoViewController: UIViewController {

    @IBOutlet weak var nameField: TextField!
    @IBOutlet weak var surnameField: TextField!
    @IBOutlet weak var genderSelector: DropdownControl!
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var phoneNumberField: PhoneNumberField!
    @IBOutlet weak var passwordField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
    }

}
