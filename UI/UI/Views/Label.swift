//
//  Label.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
public class Label: UILabel {

    @IBInspectable
    var lineHeight: CGFloat = 1.0 {
        didSet {
            setUpView()
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
        setNeedsDisplay()
    }
    
    func setUpView() {
        setLineHeight(lineHeight: lineHeight)
    }
    
}
