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
    
    // MARK: - Properties
    
    @IBInspectable
    public var placeholder: String = "Dropdown button" {
        didSet { updateLabel() }
    }
    
    @IBInspectable
    public var value: String? {
        didSet { updateLabel() }
    }
    
    // MARK: - Views
    
    private lazy var valueLabel: Label = {
        let label = Label()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.MontserratMedium.of(size: 14)
        label.textColor = UIColor.ThemeColors.blackColor
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
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
        updateLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupLayout()
        updateLabel()
    }
    
    // MARK: - Setups
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
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
        borderWidth = 1
        borderColor = UIColor.ThemeColors
            .blackColor
            .withAlphaComponent(0.5)
        cornerRadius = 10
        
        setupArrow()
    }
    
    private func setupArrow() {
        let iconImage = UIImage(
            named: "Dropdown-Arrow",
            in: Bundle(for: DropdownControl.self),
            compatibleWith: nil
        )
        iconImageView.image = iconImage?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor.ThemeColors.blackColor.withAlphaComponent(0.8)
    }
    
    private func updateLabel() {
        if value == nil || value == "" {
            valueLabel.alpha = 0.5
            valueLabel.text = placeholder
        } else {
            valueLabel.alpha = 1
            valueLabel.text = value
        }
    }
    
    // MARK: - Touches
    
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
