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
    var offTintColor: UIColor? = UIColor.ThemeColors.blackColor {
        didSet {
            setOffTintColor(offTintColor)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaultColors()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefaultColors()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupDefaultColors()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupDefaultColors()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        layer.cornerRadius = frame.height / 2
    }
    
    private func setupDefaultColors() {
        if onTintColor == nil {
            onTintColor = UIColor.ThemeColors.brandBlueColor
        }
        setOffTintColor(offTintColor)
    }
    
    private func setOffTintColor(_ color: UIColor?) {
        tintColor = color
        backgroundColor = color
    }
    
}
