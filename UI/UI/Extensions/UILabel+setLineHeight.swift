//
//  UILabel+setLineHeight.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = textAlignment
        
        let attrString = NSMutableAttributedString()
        if let attributedText = attributedText {
            attrString.append(attributedText)
        } else if let text = text {
            attrString.append(NSMutableAttributedString(string: text))
            if let font = font {
                attrString.addAttribute(
                    NSAttributedString.Key.font,
                    value: font,
                    range: NSRange(location: 0, length: attrString.length)
                )
            }
        }
        attrString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attrString.length)
        )
        attributedText = attrString
    }
    
}
