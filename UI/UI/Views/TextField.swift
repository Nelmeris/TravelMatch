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
    
    @IBInspectable
    public var placeholderColor: UIColor? = UIColor.TextFields.defaultTextColor.withAlphaComponent(0.5) {
        didSet {
            setPlaceholderColor(placeholderColor)
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
    
    // MARK: - Overrides
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x + horizontalPadding,
            y: bounds.origin.y + verticalPadding,
            width: bounds.size.width - horizontalPadding * 2,
            height: bounds.size.height - verticalPadding * 2
        )
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    // MARK: - Setups
    
    private func setupView() {
        clipsToBounds = true
    }
    
    private func setupDefaults() {
        setCornerRadius(cornerRadius)
        setBorderWidth(borderWidth)
        setPlaceholderColor(placeholderColor)
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
        setPlaceholderColor(!value ? defaultTextColor?.withAlphaComponent(0.5) : invalidTextColor?.withAlphaComponent(0.5))
    }
    
    private func setPlaceholderColor(_ value: UIColor?) {
        let attributes = [NSAttributedString.Key.foregroundColor: value as Any]
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                   attributes: attributes)
    }
    
}
