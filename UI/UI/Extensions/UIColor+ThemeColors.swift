//
//  UIColor+ThemeColors.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 16.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct ThemeColors {
        static let primaryColor = UIColor(hexString: "#304E7E")
        static let secondaryColor = UIColor(hexString: "#D8D8D8")
        static let textColor = UIColor(hexString: "#2B2A2E")
    }
    
}

// MARK: - Buttons
extension UIColor {
    
    struct Buttons {
        static let primaryBackgroundColor = UIColor.ThemeColors.primaryColor
        static let primaryTextColor = UIColor.white
        
        static let secondaryBackgroundColor = UIColor.ThemeColors.secondaryColor
        static let secondaryTextColor = UIColor.ThemeColors.textColor
        
        static let disabledBackgroundColor = UIColor(hexString: "#E4E4E4")
        static let disabledTextColor = UIColor(hexString: "#A0A0A0")
        
    }
    
}
