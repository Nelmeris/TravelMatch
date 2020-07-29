//
//  PasswordSentViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 25.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class PasswordSentViewController: BaseViewController {

    // MARK: - Input
    
    var message: String? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Output
    
    var onLoginButtonClicked: (() -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var messageLabel: Label?
    
    // MARK: - Actions

    @IBAction func loginButtonClicked(_ sender: Any) {
        onLoginButtonClicked?()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
        
    // MARK: - Update view
    
    private func updateView() {
        messageLabel?.text = message
        view.setNeedsLayout()
    }
}
