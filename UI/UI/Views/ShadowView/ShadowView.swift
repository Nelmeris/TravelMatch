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

    // MARK: - Properties
    
    @IBInspectable
    public var gradientShadowColor: UIColor = .black {
        didSet {
            gradientLayer.colors?[1] = shadowGradientColor
        }
    }

    @IBInspectable
    public var gradientShadowOpacity: CGFloat = 0.7 {
        didSet {
            gradientLayer.colors?[1] = shadowGradientColor
        }
    }
    
    @IBInspectable
    public var gradientShadowSize: CGFloat = 0.6 {
        didSet {
            gradientLayer.frame = gradientFrame
        }
    }
    
    @IBInspectable
    public override var cornerRadius: CGFloat {
        get { return super.cornerRadius }
        set {
            super.cornerRadius = newValue
            gradientLayer.cornerRadius = newValue
        }
    }
    
    // MARK: - Layers
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        
        gradient.colors = [
            UIColor.white.withAlphaComponent(0).cgColor,
            shadowGradientColor
        ]
        
        gradient.frame = gradientFrame
        gradient.cornerRadius = cornerRadius
        
        layer.insertSublayer(gradient, below: nil)
        return gradient
    }()
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = gradientFrame
    }
    
    // MARK: - Setups
    
    private func setupView() {
        backgroundColor = .clear
        gradientShadowColor = .black
        gradientShadowOpacity = 0.7
        gradientShadowSize = 0.6
    }
    
    private var gradientFrame: CGRect {
        let shadowHeight: CGFloat = bounds.height * gradientShadowSize
        let frame = CGRect(
            x: 0,
            y: bounds.height - shadowHeight,
            width: bounds.width,
            height: shadowHeight
        )
        return frame
    }
    
    private var shadowGradientColor: CGColor {
        return gradientShadowColor.withAlphaComponent(CGFloat(gradientShadowOpacity)).cgColor
    }
    
}
