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
    
    // MARK: - Properties
    
    @IBInspectable
    var horizontalPadding: CGFloat = 10
    
    @IBInspectable
    var verticalPadding: CGFloat = 6

    @IBInspectable
    var cornerRadius: CGFloat = 10 {
        didSet {
            setCornerRadius(cornerRadius)
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 1 {
        didSet {
            setBorderWidth(borderWidth)
        }
    }
    
    @IBInspectable
    public var isInvalid: Bool = false {
        didSet {
            setIsInvalid(isInvalid)
        }
    }
    
    @IBInspectable
    public var defaultTextColor: UIColor? = UIColor.TextFields.defaultTextColor {
        didSet {
            setIsInvalid(isInvalid)
        }
    }
    
    @IBInspectable
    public var invalidTextColor: UIColor? = UIColor.TextFields.invalidTextColor {
        didSet {
            setIsInvalid(isInvalid)
        }
    }
    
    @IBInspectable
    public var defaultBorderColor: UIColor = UIColor.TextFields.defaultBorderColor {
        didSet {
            setIsInvalid(isInvalid)
        }
    }
    
    @IBInspectable
    public var invalidBorderColor: UIColor? = UIColor.TextFields.invalidBorderColor {
        didSet {
            setIsInvalid(isInvalid)
        }
    }
    
    // MARK: - Lifecycle
    
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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        flagButton.frame = CGRect(
            x: horizontalPadding,
            y: flagButton.frame.minY,
            width: flagButton.frame.width,
            height: flagButton.frame.height
        )
    }
    
    // MARK: - Overrides
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        let countryButtonSpace: CGFloat = withFlag ? 30.0 : 0.0
        
        return CGRect(
            x: bounds.origin.x + horizontalPadding + countryButtonSpace,
            y: bounds.origin.y + verticalPadding,
            width: bounds.size.width - horizontalPadding * 2 - countryButtonSpace,
            height: bounds.size.height - verticalPadding * 2
        )
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    // MARK: - Setups
    
    private func setupView() {
        clipsToBounds = true
        withFlag = true
        withPrefix = true
        withExamplePlaceholder = true
        if #available(iOS 11.0, *) {
            withDefaultPickerUI = true
        }
    }
    
    private func setupDefaults() {
        setCornerRadius(cornerRadius)
        setBorderWidth(borderWidth)
        setIsInvalid(isInvalid)
    }
    
    private func setCornerRadius(_ value: CGFloat) {
        layer.cornerRadius = value
    }
    
    private func setBorderWidth(_ value: CGFloat) {
        layer.borderWidth = value
    }
    
    private func setBorderColor(_ value: UIColor?) {
        layer.borderColor = value?.cgColor
    }
    
    private func setTextColor(_ value: UIColor?) {
        textColor = value
    }
    
    private func setIsInvalid(_ value: Bool) {
        setTextColor(!value ? defaultTextColor : invalidTextColor)
        setBorderColor(!value ? defaultBorderColor : invalidBorderColor)
    }
        
}
