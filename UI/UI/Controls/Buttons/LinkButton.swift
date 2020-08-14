//
//  LinkButton.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 16.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

public class LinkButton: Button {

    override func setupView() {
        super.setupView()
        
        guard
            let title = title(for: .normal),
            let font = titleLabel?.font
            else { return }
        
        let attrString = NSMutableAttributedString()
        
        if let attrTitle = attributedTitle(for: .normal) {
            attrString.append(attrTitle)
        } else {
            attrString.append(NSMutableAttributedString(string: title))
            attrString.addAttribute(
                NSAttributedString.Key.font,
                value: font,
                range: NSRange(location: 0, length: attrString.length)
            )
        }
        
        attrString.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attrString.length)
        )
        
        setAttributedTitle(attrString, for: .normal)
    }

}
