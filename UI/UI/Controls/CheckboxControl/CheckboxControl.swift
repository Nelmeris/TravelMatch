//
//  CheckboxControl.swift
//  UI
//
//  Created by Maxim Timokhin on 27.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
public class CheckboxControl: UIControl {

    @IBInspectable
    public var isChecked: Bool = false {
        didSet {
            setupView()
        }
    }

    private lazy var checkMarkLayer: CALayer = {
        let layer = CALayer()
        
        guard let checkboxImage = UIImage(
            named: "checkbox",
            in: .init(for: CheckboxControl.self),
            compatibleWith: nil
            ) else {
                layer.backgroundColor = UIColor.red.cgColor
                return layer
        }
        
        layer.frame = CGRect(
            x: 0,
            y: 0,
            width: checkboxImage.size.width,
            height: checkboxImage.size.height
        )
        layer.backgroundColor = UIColor.ThemeColors.blackColor.cgColor

        let mask = CALayer()
        mask.frame = layer.bounds
        mask.contents = checkboxImage.cgImage
        layer.mask = mask
        layer.masksToBounds = true
        
        self.layer.addSublayer(layer)
        return layer
    }()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateLayers()
    }
    
    private func setupView() {
        checkMarkLayer.opacity = isChecked ? 1 : 0
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.ThemeColors.blackColor.cgColor
        layer.cornerRadius = 4
    }
    
    private func updateLayers() {
        checkMarkLayer.frame.origin = CGPoint(
            x: bounds.width / 2 - checkMarkLayer.frame.width / 2,
            y: bounds.height / 2 - checkMarkLayer.frame.height / 2
        )
    }
    
}
