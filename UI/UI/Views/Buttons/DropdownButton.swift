//
//  DropdownButton.swift
//  UI
//
//  Created by Maxim Timokhin on 20.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@IBDesignable
public class DropdownButton: UIButton {

    
    @IBInspectable
    var horizontalPadding: CGFloat = 10
    
    @IBInspectable
    var verticalPadding: CGFloat = 6

    @IBInspectable
    var cornerRadius: CGFloat = 10 {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.TextFields.defaultBorderColor {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 1 {
        didSet {
            setUpView()
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
    }

}
