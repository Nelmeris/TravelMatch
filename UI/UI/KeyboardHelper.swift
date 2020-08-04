//
//  KeyboardHelper.swift
//  Core
//
//  Created by Artem Kufaev on 04.08.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

public class KeyboardHelper {
    
    public static func parseFrame(from notification: Notification) -> CGRect? {
        guard let userInfo = notification.userInfo,
            let keyboardValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else { return nil }
        return keyboardValue.cgRectValue
    }
    
}
