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

    private func setupView() {
        clipsToBounds = true
    }
    
    private func setupDefaults() {
        cornerRadius = 10
        if borderColor != nil {
            borderWidth = 1
        } else {
            borderWidth = 0
        }
    }
}
