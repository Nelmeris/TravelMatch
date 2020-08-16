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
    public var isInvalid: Bool = false {
        didSet { updateColors() }
    }
    
    @IBInspectable
    public var defaultTextColor: UIColor? = UIColor.TextFields.defaultTextColor {
        didSet { updateColors() }
    }
    
    @IBInspectable
    public var invalidTextColor: UIColor? = UIColor.TextFields.invalidTextColor {
        didSet { updateColors() }
    }
    
    @IBInspectable
    public var defaultBorderColor: UIColor? = UIColor.TextFields.defaultBorderColor {
        didSet { updateColors() }
    }
    
    @IBInspectable
    public var invalidBorderColor: UIColor? = UIColor.TextFields.invalidBorderColor {
        didSet { updateColors() }
    }
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupDefaults()
    }
    
    public override init(frame: CGRect, phoneNumberKit: PhoneNumberKit) {
        super.init(frame: frame, phoneNumberKit: phoneNumberKit)
        setupView()
        setupDefaults()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupDefaults()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupFlagButtonFrame()
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
        borderStyle = .none
        withFlag = true
        withPrefix = true
        withExamplePlaceholder = true
        if #available(iOS 11.0, *) {
            withDefaultPickerUI = true
        }
    }
    
    private func setupDefaults() {
        cornerRadius = 10
        borderWidth = 1
        defaultTextColor = UIColor.TextFields.defaultTextColor
        invalidTextColor = UIColor.TextFields.invalidTextColor
        defaultBorderColor = UIColor.TextFields.defaultBorderColor
        invalidBorderColor = UIColor.TextFields.invalidBorderColor
        updateColors()
    }
    
    private func updateColors() {
        textColor = !isInvalid ?
            defaultTextColor :
            invalidTextColor
        borderColor = !isInvalid ?
            defaultBorderColor :
            invalidBorderColor
        setPlaceholderColor(!isInvalid ?
            defaultTextColor?.withAlphaComponent(0.5) :
            invalidTextColor?.withAlphaComponent(0.5)
        )
    }
    
    private func setPlaceholderColor(_ color: UIColor?) {
        let attributes = [NSAttributedString.Key.foregroundColor: color as Any]
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                   attributes: attributes)
    }
    
    private func setupFlagButtonFrame() {
        flagButton.frame = CGRect(
            x: horizontalPadding,
            y: flagButton.frame.minY,
            width: flagButton.frame.width,
            height: flagButton.frame.height
        )
    }
        
}
