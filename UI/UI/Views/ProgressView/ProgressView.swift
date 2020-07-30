//
//  ProgressView.swift
//  UI
//
//  Created by Maxim Timokhin on 19.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
public class ProgressView: UIView {

    // MARK: - Properties
    
    @IBInspectable
    /// 0..100
    public var value: Int = 0 {
        didSet { setupView() }
    }
    
    @IBInspectable
    public var firstColor: UIColor = .black {
        didSet { setupView() }
    }
    
    @IBInspectable
    public var secondColor: UIColor = .darkGray {
        didSet { setupView() }
    }
    
    // MARK: - Lifecycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    private func setupView() {
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius

        // setup gradient
        let gradient = CAGradientLayer()
        
        let gradientWidth: CGFloat = CGFloat(value) / 100 * bounds.width
        
        gradient.frame = CGRect(
            x: 0,
            y: 0,
            width: gradientWidth,
            height: bounds.height
        )
        gradient.colors = [
            firstColor.cgColor,
            secondColor.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.cornerRadius = layer.cornerRadius
        
        // replace gradient as needed
        if let oldGradient = layer.sublayers?[0] as? CAGradientLayer {
            layer.replaceSublayer(oldGradient, with: gradient)
        } else {
            layer.insertSublayer(gradient, below: nil)
        }
    }

}
