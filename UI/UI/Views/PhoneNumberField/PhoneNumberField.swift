//
//  PhoneNumberField.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 17.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import PhoneNumberKit

@IBDesignable
public class PhoneNumberField: PhoneNumberTextField {

    @IBInspectable
    var horizontalPadding: CGFloat = 10
    
    @IBInspectable
    var verticalPadding: CGFloat = 6

    @IBInspectable
    var cornerRadius: CGFloat = 10 {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.TextFields.defaultBorderColor {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 1 {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable
    public var isInvalid: Bool = false {
        didSet {
            setUpView()
        }
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let countryButtonSpace: CGFloat = withFlag ? 30.0 : 0.0
        
        return CGRect(
            x: bounds.origin.x + horizontalPadding + countryButtonSpace,
            y: bounds.origin.y + verticalPadding,
            width: bounds.size.width - horizontalPadding * 2 - countryButtonSpace,
            height: bounds.size.height - verticalPadding * 2
        )
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        flagButton.frame = CGRect(
            x: horizontalPadding,
            y: flagButton.frame.minY,
            width: flagButton.frame.width,
            height: flagButton.frame.height
        )
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
        
        if isInvalid {
            self.textColor = UIColor.TextFields.invalidTextColor
            self.layer.borderColor = UIColor.TextFields.invalidBorderColor.cgColor
        } else {
            self.textColor = UIColor.TextFields.defaultTextColor
            self.layer.borderColor = borderColor.cgColor
        }
        
        withFlag = true
        withPrefix = true
        withExamplePlaceholder = true
        if #available(iOS 11.0, *) {
            withDefaultPickerUI = true
        }
    }
        
}
