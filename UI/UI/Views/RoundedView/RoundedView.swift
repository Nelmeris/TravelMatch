//
//  RoundedView.swift
//  UI
//
//  Created by Maxim Timokhin on 30.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
public class RoundedView: UIView {

    @IBInspectable
    var cornerRadius: CGFloat = 10.0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        didSet {
            setupView()
        }
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
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        
        if let borderColor = borderColor {
            layer.borderWidth = 1
            layer.borderColor = borderColor.cgColor
        } else {
            layer.borderWidth = 0
        }
    }
}
