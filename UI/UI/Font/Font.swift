//
//  Font.swift
//  UI
//
//  Created by Maxim Timokhin on 21.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

public enum Font: String {
    case LatoRegular = "Lato-Regular"
    case MontserratRegular = "Montserrat-Regular"
    case MontserratMedium = "Montserrat-Medium"
    case MontserratSemiBold = "Montserrat-SemiBold"
    case MontserratBold = "Montserrat-Bold"
    case MontserratExtraBold = "Montserrat-ExtraBold"
    
    public func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}
