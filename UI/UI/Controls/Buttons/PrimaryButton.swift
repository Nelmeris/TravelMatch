//
//  PrimaryButton.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 16.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
public class PrimaryButton: Button {
    
    public override var isEnabled: Bool {
        didSet {
            setupBackgroundColor()
        }
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setTitleColor(UIColor.Buttons.primaryTextColor, for: .normal)
        setTitleColor(UIColor.Buttons.disabledTextColor, for: .disabled)
        setupBackgroundColor()
    }
    
    override func setupView() {
        super.setupView()
        setTitleColor(UIColor.Buttons.primaryTextColor, for: .normal)
        setTitleColor(UIColor.Buttons.disabledTextColor, for: .disabled)
        setupBackgroundColor()
    }
    
    private func setupBackgroundColor() {
        backgroundColor = isEnabled ?
            UIColor.Buttons.primaryBackgroundColor :
            UIColor.Buttons.disabledBackgroundColor
    }

}
