//
//  UIColor+ThemeColors.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 16.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

extension UIColor {
    
    public struct ThemeColors {
        public static let brandBlueColor = UIColor(hexString: "#304E7E")
        public static let mediumGrayColor = UIColor(hexString: "#D8D8D8")
        public static let blackColor = UIColor(hexString: "#2B2A2E")
        public static let redColor = UIColor(hexString: "#F25757")
    }
    
}

// MARK: - Buttons
extension UIColor {
    
    public struct Buttons {
        public static let primaryBackgroundColor = UIColor.ThemeColors.brandBlueColor
        public static let primaryTextColor = UIColor.white
        
        public static let secondaryBackgroundColor = UIColor.ThemeColors.mediumGrayColor
        public static let secondaryTextColor = UIColor.ThemeColors.blackColor
        
        public static let disabledBackgroundColor = UIColor(hexString: "#E4E4E4")
        public static let disabledTextColor = UIColor(hexString: "#A0A0A0")
        
    }
    
}

// MARK: - Text fields
extension UIColor {
    
    public struct TextFields {
        public static let defaultTextColor = UIColor.ThemeColors.blackColor
        public static let defaultBorderColor = UIColor.ThemeColors.blackColor.withAlphaComponent(0.5)
        public static let invalidTextColor = UIColor.ThemeColors.redColor
        public static let invalidBorderColor = UIColor.ThemeColors.redColor.withAlphaComponent(0.5)
    }
    
}
