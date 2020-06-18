//
//  Button.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
class Button: UIButton {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            setupView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.cornerRadius
        self.clipsToBounds = true
    }
    
}
