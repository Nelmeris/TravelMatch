//
//  SecondaryButton.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 16.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

class SecondaryButton: Button {
    
    override var isEnabled: Bool {
        didSet {
            setupView()
        }
    }
    
    override func setupView() {
        super.setupView()
        
        setTitleColor(UIColor.Buttons.secondaryTextColor, for: .normal)
        setTitleColor(UIColor.Buttons.disabledTextColor, for: .disabled)

        if isEnabled {
            backgroundColor = UIColor.Buttons.secondaryBackgroundColor
        } else {
            backgroundColor = UIColor.Buttons.disabledBackgroundColor
        }
    }

}
