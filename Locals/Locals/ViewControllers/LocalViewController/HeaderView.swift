//
//  HeaderView.swift
//  Locals
//
//  Created by Maxim Timokhin on 19.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import UI

class HeaderView: UIView {

    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet var imageView: ImageView!
    @IBOutlet var titleLabel: Label!
    
    func configure(with imageURL: URL, title: String) {
        imageView.imageURL = imageURL
        titleLabel.text = title
    }
    
}
