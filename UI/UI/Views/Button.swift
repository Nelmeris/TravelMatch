//
//  Button.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
public class Button: UIButton {

    public override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupDefaults()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
        setupDefaults()
    }
    
    func setupView() {
        clipsToBounds = true
    }
    
    private func setupDefaults() {
        layer.cornerRadius = cornerRadius
    }
    
}
