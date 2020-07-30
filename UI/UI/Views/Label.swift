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
        didSet { setupView() }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        setLineHeight(lineHeight: lineHeight)
    }
    
}
