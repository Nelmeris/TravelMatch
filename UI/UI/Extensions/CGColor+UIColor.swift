//
//  CGColor+UIColor.swift
//  UI
//
//  Created by Artem Kufaev on 30.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

public extension CGColor {
    var uiColor: UIKit.UIColor {
        return UIKit.UIColor(cgColor: self)
    }
}
