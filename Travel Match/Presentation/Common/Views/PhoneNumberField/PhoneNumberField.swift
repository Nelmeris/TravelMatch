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
class PhoneNumberField: PhoneNumberTextField {

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
    var borderColor: UIColor = .darkGray {
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
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let countryButtonSpace: CGFloat = withFlag ? 30.0 : 0.0
        
        return CGRect(
            x: bounds.origin.x + horizontalPadding + countryButtonSpace,
            y: bounds.origin.y + verticalPadding,
            width: bounds.size.width - horizontalPadding * 2 - countryButtonSpace,
            height: bounds.size.height - verticalPadding * 2
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flagButton.frame = CGRect(
            x: horizontalPadding,
            y: flagButton.frame.minY,
            width: flagButton.frame.width,
            height: flagButton.frame.height
        )
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
        
        withFlag = true
        withPrefix = true
        withExamplePlaceholder = true
        if #available(iOS 11.0, *) {
            withDefaultPickerUI = true
        }
    }
        
}
