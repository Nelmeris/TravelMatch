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
        didSet {
            if value > 100 {
                value = 100
            }
            if value < 0 {
                value = 0
            }
            updateGradientFrame()
        }
    }
    
    @IBInspectable
    public var firstColor: UIColor = .black {
        didSet {
            gradientLayer.colors?[0] = firstColor.cgColor
        }
    }
    
    @IBInspectable
    public var secondColor: UIColor = .darkGray {
        didSet {
            gradientLayer.colors?[1] = secondColor.cgColor
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
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        gradient.colors = [
            firstColor.cgColor,
            secondColor.cgColor
        ]
        
        layer.insertSublayer(gradient, below: nil)
        return gradient
    }()
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }
    
    // MARK: - Private
    
    private func setupView() {
        layer.masksToBounds = true
        value = 50
        firstColor = .black
        secondColor = .darkGray
        cornerRadius = 10
    }
    
    private func updateGradientFrame() {
        let gradientWidth: CGFloat = CGFloat(value) / 100 * bounds.width
        
        gradientLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: gradientWidth,
            height: bounds.height
        )
    }

}
