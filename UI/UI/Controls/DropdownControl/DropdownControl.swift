//
//  DropdownControl.swift
//  UI
//
//  Created by Maxim Timokhin on 21.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
public class DropdownControl: UIControl {
    
    // MARK: - Public
    
    @IBInspectable
    public var placeholder: String = "Dropdown button" {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable
    public var value: String? {
        didSet {
            setupView()
        }
    }
    
    // MARK: - Private
    
    private lazy var placeholderLabel: Label = {
        let label = Label()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.MontserratRegular.of(size: 14)
        label.textColor = UIColor.ThemeColors.blackColor
        label.alpha = 0.7
        addSubview(label)
        
        return label
    }()
    
    private lazy var valueLabel: Label = {
        let label = Label()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.MontserratMedium.of(size: 14)
        label.textColor = UIColor.ThemeColors.blackColor
        label.isHidden = true
        addSubview(label)
        
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        return imageView
    }()
        
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
        setupView()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupLayout()
        setupView()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            placeholderLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            placeholderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            placeholderLabel.rightAnchor.constraint(equalTo: iconImageView.leftAnchor, constant: -20),
            valueLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueLabel.rightAnchor.constraint(equalTo: iconImageView.leftAnchor, constant: -20),
            iconImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            iconImageView.widthAnchor.constraint(equalToConstant: 13),
            iconImageView.heightAnchor.constraint(equalToConstant: 13),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupView() {
        placeholderLabel.text = placeholder
        valueLabel.text = value
        
        if value == nil {
            placeholderLabel.isHidden = false
            valueLabel.isHidden = true
        } else {
            placeholderLabel.isHidden = true
            valueLabel.isHidden = false
        }
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.ThemeColors
            .blackColor
            .withAlphaComponent(0.5)
            .cgColor
        layer.cornerRadius = cornerRadius
        
        let iconImage = UIImage(
            named: "Dropdown-Arrow",
            in: Bundle(for: DropdownControl.self),
            compatibleWith: nil
        )
        
        iconImageView.image = iconImage?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor.ThemeColors.blackColor.withAlphaComponent(0.8)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        layer.removeAllAnimations()
        UIView.animate(withDuration: 0.15) {
            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.15) {
            self.transform = .identity
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.15) {
            self.transform = .identity
        }
    }
    
}
