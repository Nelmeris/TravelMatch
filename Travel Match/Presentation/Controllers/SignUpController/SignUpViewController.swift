//
//  SignUpViewController.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 17.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextButton: Button!
    @IBOutlet weak var facebookButton: Button!
    @IBOutlet weak var nameField: TextField! {
        didSet {
            nameField.autocorrectionType = .no
            nameField.inputAccessoryView = nil
        }
    }
    @IBOutlet weak var passwordField: TextField! {
        didSet {
            passwordField.autocorrectionType = .no
            passwordField.inputAccessoryView = nil
        }
    }
    
    @IBOutlet var buttonsHeightConstraint: NSLayoutConstraint!
    @IBOutlet var formHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = ""
        nameField.autocorrectionType = .no
    }

    // MARK: - Notifications
    
    override func addNotifications() {
        super.addNotifications()
        notificationCenter.addObserver(self, selector:
            #selector(self.keyboardWillShown), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        
        notificationCenter.addObserver(self, selector:
            #selector(self.keyboardWillHide(notification:)), name:
            UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func removeNotifications() {
        super.removeNotifications()
        notificationCenter.removeObserver(self, name:
            UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name:
            UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func scrollViewTapAction(_ sender: Any) {
        scrollView.endEditing(true)
    }
        
    @IBAction func facebookButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
    }
    
    @objc func keyboardWillShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary

        guard
            let kbSize = (
                info.value(
                    forKey: UIResponder.keyboardFrameEndUserInfoKey
                    ) as? NSValue)?.cgRectValue.size,
            let animationDuration = info.value(forKey: UIResponder.keyboardAnimationDurationUserInfoKey) as? CGFloat
            else { return }

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom:
            kbSize.height, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        NSLayoutConstraint.deactivate([
            buttonsHeightConstraint
        ])
        
        let buttonSpaceHeight: CGFloat = 128
        formHeightConstraint.constant =
            (view.frame.height - kbSize.height - buttonSpaceHeight)
            - view.frame.height * formHeightConstraint.multiplier
        
        facebookButton.alpha = 0
        facebookButton.isHidden = true
        
        view.setNeedsLayout()
        view.layer.removeAllAnimations()
        UIView.animate(withDuration: TimeInterval(animationDuration)) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let info = notification.userInfo! as NSDictionary

        guard
            let animationDuration = info.value(forKey: UIResponder.keyboardAnimationDurationUserInfoKey) as? CGFloat
            else { return }
        
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        facebookButton.alpha = 1
        facebookButton.isHidden = false
        
        NSLayoutConstraint.activate([
            buttonsHeightConstraint
        ])
        
        formHeightConstraint.constant = 0
        
        view.setNeedsLayout()
        view.layer.removeAllAnimations()
        UIView.animate(withDuration: TimeInterval(animationDuration)) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}
