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
        static let brandBlueColor = UIColor(hexString: "#304E7E")
        static let mediumGrayColor = UIColor(hexString: "#D8D8D8")
        static let blackColor = UIColor(hexString: "#2B2A2E")
        static let redColor = UIColor(hexString: "#F25757")
    }
    
}

// MARK: - Buttons
extension UIColor {
    
    struct Buttons {
        static let primaryBackgroundColor = UIColor.ThemeColors.brandBlueColor
        static let primaryTextColor = UIColor.white
        
        static let secondaryBackgroundColor = UIColor.ThemeColors.mediumGrayColor
        static let secondaryTextColor = UIColor.ThemeColors.blackColor
        
        static let disabledBackgroundColor = UIColor(hexString: "#E4E4E4")
        static let disabledTextColor = UIColor(hexString: "#A0A0A0")
        
    }
    
}

// MARK: - Text fields
extension UIColor {
    
    struct TextFields {
        static let defaultTextColor = UIColor.ThemeColors.blackColor
        static let defaultBorderColor = UIColor.ThemeColors.blackColor.withAlphaComponent(0.5)
        static let invalidTextColor = UIColor.ThemeColors.redColor
        static let invalidBorderColor = UIColor.ThemeColors.redColor.withAlphaComponent(0.5)
    }
    
}
