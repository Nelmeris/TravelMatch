//
//  Switch.swift
//  UI
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
public class Switch: UISwitch {
    
    @IBInspectable
    var offTintColor: UIColor? = UIColor.ThemeColors.blackColor.withAlphaComponent(0.6) {
        didSet {
            setOffTintColor(offTintColor)
        }
    }
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaults()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefaults()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        if onTintColor == nil {
            onTintColor = UIColor.ThemeColors.brandBlueColor
        }
        setOffTintColor(offTintColor)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setupDefaults() {
        onTintColor = UIColor.ThemeColors.brandBlueColor
        offTintColor = UIColor.ThemeColors.blackColor.withAlphaComponent(0.6)
    }
    
    private func setupLayout() {
        cornerRadius = frame.height / 2
    }
    
    private func setOffTintColor(_ color: UIColor?) {
        tintColor = color
        backgroundColor = color
    }
    
}
