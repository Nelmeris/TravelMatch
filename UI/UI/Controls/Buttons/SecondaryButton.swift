//
//  SecondaryButton.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 16.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
public class SecondaryButton: Button {
    
    public override var isEnabled: Bool {
        didSet {
            setupBackgroundColor()
        }
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setTitleColor(UIColor.Buttons.secondaryTextColor, for: .normal)
        setTitleColor(UIColor.Buttons.disabledTextColor, for: .disabled)
    }
    
    override func setupView() {
        super.setupView()
        
        setTitleColor(UIColor.Buttons.secondaryTextColor, for: .normal)
        setTitleColor(UIColor.Buttons.disabledTextColor, for: .disabled)
    }
    
    private func setupBackgroundColor() {
        backgroundColor = isEnabled ?
            UIColor.Buttons.secondaryBackgroundColor :
            UIColor.Buttons.disabledBackgroundColor
    }

}
