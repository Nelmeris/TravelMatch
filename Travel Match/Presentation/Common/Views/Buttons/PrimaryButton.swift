//
//  PrimaryButton.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 16.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
class PrimaryButton: Button {
    
    override var isEnabled: Bool {
        didSet {
            setupView()
        }
    }
    
    override func setupView() {
        super.setupView()
        
        setTitleColor(UIColor.Buttons.primaryTextColor, for: .normal)
        setTitleColor(UIColor.Buttons.disabledTextColor, for: .disabled)

        if isEnabled {
            backgroundColor = UIColor.Buttons.primaryBackgroundColor
        } else {
            backgroundColor = UIColor.Buttons.disabledBackgroundColor
        }
    }

}
