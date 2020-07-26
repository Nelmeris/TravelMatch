//
//  TextField.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 14.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
public class TextField: UITextField {
    
    @IBInspectable
    var horizontalPadding: CGFloat = 10
    
    @IBInspectable
    var verticalPadding: CGFloat = 6

    @IBInspectable
    var cornerRadius: CGFloat = 10 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.TextFields.defaultBorderColor {
        didSet {
            setupColors()
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 1 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    public var isInvalid: Bool = false {
        didSet {
            setupColors()
        }
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x + horizontalPadding,
            y: bounds.origin.y + verticalPadding,
            width: bounds.size.width - horizontalPadding * 2,
            height: bounds.size.height - verticalPadding * 2
        )
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    private func setupView() {
        self.clipsToBounds = true
    }
    
    private func setupColors() {
        if isInvalid {
            self.textColor = UIColor.TextFields.invalidTextColor
            self.layer.borderColor = UIColor.TextFields.invalidBorderColor.cgColor
        } else {
            self.textColor = UIColor.TextFields.defaultTextColor
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
}
