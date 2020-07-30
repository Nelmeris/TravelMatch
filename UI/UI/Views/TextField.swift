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
    public var defaultBorderColor: UIColor? = UIColor.TextFields.invalidBorderColor {
        didSet { updateColors() }
    }
    
    @IBInspectable
    public var invalidBorderColor: UIColor? = UIColor.TextFields.invalidBorderColor {
        didSet { updateColors() }
    }
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaults()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefaults()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
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
        borderStyle = .none
    }
    
    private func setupDefaults() {
        cornerRadius = 10
        borderWidth = 1
        defaultTextColor = UIColor.TextFields.defaultTextColor
        invalidTextColor = UIColor.TextFields.invalidTextColor
        borderColor = UIColor.TextFields.defaultBorderColor
        invalidBorderColor = UIColor.TextFields.invalidBorderColor
        updateColors()
    }
    
    private func updateColors() {
        textColor = !isInvalid ?
            defaultTextColor :
            invalidTextColor
        borderColor = !isInvalid ?
            borderColor :
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
    
}
