//
//  KeyboardHelper.swift
//  Core
//
//  Created by Artem Kufaev on 04.08.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

public enum KeyboardState {
    case show(frame: CGRect)
    case change(frame: CGRect)
    case hide
}

public class KeyboardHelper {
    
    public static func parseFrame(from notification: Notification) -> CGRect? {
        guard let userInfo = notification.userInfo,
            let keyboardValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else { return nil }
        return keyboardValue.cgRectValue
    }
    
    public static func parse(from notification: Notification) -> KeyboardState? {
        guard let keyboardFrame = parseFrame(from: notification) else { return nil }
        switch notification.name {
        case UIResponder.keyboardWillShowNotification:
            return .show(frame: keyboardFrame)
        case UIResponder.keyboardWillHideNotification:
            return .hide
        case UIResponder.keyboardWillChangeFrameNotification:
            return .change(frame: keyboardFrame)
        default:
            return nil
        }
    }
    
}
