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
    var shadowSize: CGFloat = 0.6 {
        didSet { updateGradientFrame() }
    }
    
    public override var shadowColor: UIColor? {
        get { return super.shadowColor }
        set {
            super.shadowColor = newValue
            updateShadowColor()
        }
    }
    
    public override var shadowOpacity: Float {
        get { return super.shadowOpacity }
        set {
            super.shadowOpacity = newValue
            updateShadowColor()
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
            UIColor.clear.cgColor,
            shadowColor?.withAlphaComponent(CGFloat(shadowOpacity)) as Any
        ]
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
        updateGradientFrame()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        backgroundColor = .clear
        cornerRadius = 10
        shadowOpacity = 0.7
        shadowSize = 0.6
    }
    
    private func updateGradientFrame() {
        let shadowHeight: CGFloat = bounds.height * shadowSize
        gradientLayer.frame = CGRect(
            x: 0,
            y: bounds.height - shadowHeight,
            width: bounds.width,
            height: shadowHeight
        )
    }
    
    private func updateShadowColor() {
        gradientLayer.colors?[1] = shadowColor?.withAlphaComponent(CGFloat(shadowOpacity)) as Any
    }
    
}
