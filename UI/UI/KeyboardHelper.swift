//
//  KeyboardHelper.swift
//  Core
//
//  Created by Artem Kufaev on 04.08.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

public enum KeyboardState {
    case willShow(frame: CGRect)
    case willChangeFrame(frame: CGRect)
    case willHide
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
            return .willShow(frame: keyboardFrame)
        case UIResponder.keyboardWillHideNotification:
            return .willHide
        case UIResponder.keyboardWillChangeFrameNotification:
            return .willChangeFrame(frame: keyboardFrame)
        default:
            return nil
        }
    }
    
}
