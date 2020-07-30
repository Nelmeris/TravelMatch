//
//  ShadowView.swift
//  UI
//
//  Created by Maxim Timokhin on 30.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
public class ShadowView: UIView {
    
    @IBInspectable
    var shadowSize: CGFloat = 0.6 {
        didSet {
            setupGradient()
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        setupGradient()
    }
    
    private func setupGradient() {
        let gradient = CAGradientLayer()
        let shadowHeight: CGFloat = bounds.height * shadowSize
        gradient.frame = CGRect(
            x: 0,
            y: bounds.height - shadowHeight,
            width: bounds.width,
            height: shadowHeight
        )
        gradient.colors = [
            UIColor.clear.cgColor,
            shadowColor?.withAlphaComponent(CGFloat(shadowOpacity)) as Any
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.cornerRadius = layer.cornerRadius
        
        // replace gradient as needed
        if let oldGradient = layer.sublayers?[0] as? CAGradientLayer {
            layer.replaceSublayer(oldGradient, with: gradient)
        } else {
            layer.insertSublayer(gradient, below: nil)
        }
    }
    
}
