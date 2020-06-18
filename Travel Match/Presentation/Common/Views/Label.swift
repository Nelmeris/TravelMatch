//
//  Label.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
class Label: UILabel {

    @IBInspectable
    var lineHeight: CGFloat = 1.0 {
        didSet {
            setUpView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
        setNeedsDisplay()
    }
    
    func setUpView() {
        setLineHeight(lineHeight: lineHeight)
    }
}
