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
            layer.cornerRadius = cornerRadius
        }
    }
        
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        clipsToBounds = true
    }
}
